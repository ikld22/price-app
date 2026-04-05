#!/bin/bash
# ====================================
# سكريبت تثبيت المشروع على VPS/Linux
# شغّله مرة واحدة بعد رفع الملفات
# ====================================

echo "📦 تثبيت المكتبات..."
pip install -r requirements.txt

echo "🎭 تثبيت Playwright + Chromium..."
playwright install chromium
playwright install-deps chromium

echo "✅ اكتمل التثبيت!"
echo ""
echo "▶️  لتشغيل المشروع:"
echo "    gunicorn -c gunicorn.conf.py app:app"
echo ""
echo "🔄 لتشغيله في الخلفية (لا يتوقف عند إغلاق الـ SSH):"
echo "    nohup gunicorn -c gunicorn.conf.py app:app &"