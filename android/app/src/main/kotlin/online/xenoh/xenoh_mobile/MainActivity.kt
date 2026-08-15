package online.xenoh.xenoh_mobile

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Handler
import android.os.Looper
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
        private const val CANCEL_DELAY_MS = 750L
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
                } catch (_: ActivityNotFoundException) {
                    finishPendingWithError("NO_BROWSER", "No browser is available.")
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val callback = intent.data ?: return
        if (!isAllowedCallback(callback)) return

        handler.removeCallbacks(cancelPendingAuth)
        browserWasLaunched = false
        pendingResult?.success(callback.toString())
        pendingResult = null
    }

    override fun onResume() {
        super.onResume()
        if (browserWasLaunched && pendingResult != null) {
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
            uri.path == CALLBACK_PATH

    private fun finishPendingWithError(code: String, message: String) {
        handler.removeCallbacks(cancelPendingAuth)
        browserWasLaunched = false
        pendingResult?.error(code, message, null)
        pendingResult = null
    }
}
