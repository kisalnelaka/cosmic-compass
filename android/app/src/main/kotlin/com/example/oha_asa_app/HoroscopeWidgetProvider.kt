package com.example.oha_asa_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Build
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class HoroscopeWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.horoscope_widget_layout).apply {
                val sign = widgetData.getString("widget_sign", "Pick Birthday")
                val rank = widgetData.getString("widget_rank", "")
                val item = widgetData.getString("widget_item", "...")
                val color = widgetData.getString("widget_color", "...")

                setTextViewText(R.id.widget_sign, sign)
                
                if (rank!!.isNotEmpty()) {
                    setTextViewText(R.id.widget_rank_large, "#$rank")
                    setViewVisibility(R.id.widget_rank_large, View.VISIBLE)
                } else {
                    setViewVisibility(R.id.widget_rank_large, View.GONE)
                }
                
                setTextViewText(R.id.widget_item, item)
                setTextViewText(R.id.widget_color, color)

                // App Launch Intent
                val intent = Intent(context, MainActivity::class.java)
                val pendingIntent = PendingIntent.getActivity(
                    context, 0, intent,
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                    } else {
                        PendingIntent.FLAG_UPDATE_CURRENT
                    }
                )
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
