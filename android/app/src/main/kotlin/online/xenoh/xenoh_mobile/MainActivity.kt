package online.xenoh.xenoh_mobile

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.browser.customtabs.CustomTabsIntent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "online.xenoh/oauth"
        private const val CALLBACK_SCHEME = "xenoh"
        private const val CALLBACK_HOST = "auth"
        private const val CALLBACK_PATH = "/social-callback"
        private const val FACEBOOK_COMPAT_FRAGMENT = "_=_"
        private const val CANCEL_DELAY_MS = 750L
        private const val LOG_TAG = "XenohOAuth"
    }

    private val handler = Handler(Looper.getMainLooper())
    private var pendingResult: MethodChannel.Result? = null
    private var browserWasLaunched = false
    private val cancelPendingAuth = Runnable {
        finishPendingWithError("CANCELED", "Authentication was canceled.")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method != "authenticate") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                val authorizationUrl = call.argument<String>("url")
                val authorizationUri = authorizationUrl?.let(Uri::parse)
                if (authorizationUri?.scheme != "https") {
                    result.error("INVALID_URL", "OAuth requires an HTTPS URL.", null)
                    return@setMethodCallHandler
                }
                if (pendingResult != null) {
                    result.error("IN_PROGRESS", "Authentication is already in progress.", null)
                    return@setMethodCallHandler
                }

                pendingResult = result
                browserWasLaunched = true
                try {
                    CustomTabsIntent.Builder().build().launchUrl(this, authorizationUri)
                    Log.i(LOG_TAG, "event=oauth_browser_launched")
                } catch (_: ActivityNotFoundException) {
                    finishPendingWithError("NO_BROWSER", "No browser is available.")
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        val callback = intent.data
        val allowedCallback = callback != null && isAllowedCallback(callback)
        val hasTicket = allowedCallback && callback?.getQueryParameter("ticket") != null
        val hasError = allowedCallback && callback?.getQueryParameter("error") != null
        Log.i(
            LOG_TAG,
            "event=oauth_callback_intent allowed=$allowedCallback pending=${pendingResult != null} " +
                "has_ticket=$hasTicket " +
                "has_error=$hasError " +
                "facebook_compat_fragment=${callback?.fragment == FACEBOOK_COMPAT_FRAGMENT}",
        )
        if (callback != null && allowedCallback && pendingResult != null) {
            finishPendingWithCallback(callback)
            return
        }

        super.onNewIntent(intent)
        setIntent(intent)
    }

    override fun onResume() {
        super.onResume()
        if (browserWasLaunched && pendingResult != null) {
            Log.d(LOG_TAG, "event=oauth_cancel_scheduled delay_ms=$CANCEL_DELAY_MS")
            handler.removeCallbacks(cancelPendingAuth)
            handler.postDelayed(cancelPendingAuth, CANCEL_DELAY_MS)
        }
    }

    override fun onDestroy() {
        handler.removeCallbacks(cancelPendingAuth)
        pendingResult = null
        super.onDestroy()
    }

    private fun isAllowedCallback(uri: Uri): Boolean =
        uri.scheme == CALLBACK_SCHEME &&
            uri.host == CALLBACK_HOST &&
            uri.path == CALLBACK_PATH &&
            uri.userInfo == null &&
            uri.port == -1 &&
            (uri.fragment == null || uri.fragment == FACEBOOK_COMPAT_FRAGMENT)

    private fun finishPendingWithCallback(callback: Uri) {
        handler.removeCallbacks(cancelPendingAuth)
        browserWasLaunched = false
        Log.i(LOG_TAG, "event=oauth_session_completed")
        pendingResult?.success(callback.toString())
        pendingResult = null
    }

    private fun finishPendingWithError(code: String, message: String) {
        handler.removeCallbacks(cancelPendingAuth)
        browserWasLaunched = false
        Log.w(LOG_TAG, "event=oauth_session_failed code=$code")
        pendingResult?.error(code, message, null)
        pendingResult = null
    }
}
