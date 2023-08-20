package dev.imam.rnwidget

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import org.json.JSONException
import org.json.JSONObject


/**
 * Implementation of App Widget functionality.
 */
class StreakWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }

    companion object {
        fun updateAppWidget(
            context: Context, appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            try {
                val sharedPref = context.getSharedPreferences("DATA", Context.MODE_PRIVATE)
                val appString = sharedPref.getString("appData", "{\"text\":'no data'}")
                val appData = JSONObject(appString)
                val views = RemoteViews(context.packageName, R.layout.streak_widget)
                views.setTextViewText(R.id.appwidget_text, appData.getString("text"))
                appWidgetManager.updateAppWidget(appWidgetId, views)
            } catch (e: JSONException) {
                e.printStackTrace()
            }
        }
    }
}