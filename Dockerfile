# استخدم Python خفيف ومستقر
FROM python:3.12-slim

# منع كتابة pyc + إخراج مباشر للّوج
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# إنشاء مجلد التطبيق
WORKDIR /app

# تثبيت متطلبات النظام (لو احتجت ssl / requests / stripe)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# نسخ ملفات المتطلبات
COPY requirements.txt .

# تثبيت مكتبات بايثون
RUN pip install --no-cache-dir -r requirements.txt

# نسخ باقي المشروع
COPY . .

# لو التطبيق Web (غيّر البورت لو مختلف)
EXPOSE 8000

# تشغيل التطبيق
CMD ["python", "main.py"]
