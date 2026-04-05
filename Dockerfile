FROM python:3.11-slim

# تثبيت تبعيات نظام التشغيل اللازمة لتشغيل Chromium
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    libnss3 \
    libcups2 \
    libxss1 \
    libxrandr2 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# تعيين دليل العمل
WORKDIR /app

# نسخ ملف المتطلبات وتثبيت اعتماديات Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# تثبيت متصفح Chromium باستخدام Playwright
RUN playwright install chromium

# نسخ باقي ملفات المشروع
COPY . .

# تعريف الأمر لتشغيل التطبيق
CMD ["gunicorn", "-c", "gunicorn.conf.py", "dd:app"]