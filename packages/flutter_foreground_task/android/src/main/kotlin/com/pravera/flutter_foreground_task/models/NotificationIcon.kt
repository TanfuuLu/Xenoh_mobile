package com.pravera.flutter_foreground_task.models

import org.json.JSONObject

data class NotificationIcon(
    val metaDataName: String,
    val backgroundColorRgb: String?,
    // Fork-only addition: absolute path to a local image file to show as the
    // notification's large icon (not part of upstream flutter_foreground_task).
    val largeIconPath: String? = null
) {
    companion object {
        private const val META_DATA_NAME_KEY = "metaDataName"
        private const val BACKGROUND_COLOR_RGB_KEY = "backgroundColorRgb"
        private const val LARGE_ICON_PATH_KEY = "largeIconPath"

        fun fromJsonString(jsonString: String): NotificationIcon {
            val jsonObj = JSONObject(jsonString)

            val metaDataName: String = if (jsonObj.isNull(META_DATA_NAME_KEY)) {
                ""
            } else {
                jsonObj.getString(META_DATA_NAME_KEY)
            }

            val backgroundColorRgb: String? = if (jsonObj.isNull(BACKGROUND_COLOR_RGB_KEY)) {
                null
            } else {
                jsonObj.getString(BACKGROUND_COLOR_RGB_KEY)
            }

            val largeIconPath: String? = if (!jsonObj.has(LARGE_ICON_PATH_KEY) || jsonObj.isNull(LARGE_ICON_PATH_KEY)) {
                null
            } else {
                jsonObj.getString(LARGE_ICON_PATH_KEY)
            }

            return NotificationIcon(
                metaDataName = metaDataName,
                backgroundColorRgb = backgroundColorRgb,
                largeIconPath = largeIconPath
            )
        }
    }
}
