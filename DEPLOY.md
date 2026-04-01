# دليل النشر التلقائي على DigitalOcean Droplet

يوضح هذا الدليل كيفية إعداد النشر التلقائي للبوت على DigitalOcean Droplet عبر GitHub Actions.

---

## 1. إعداد SSH Key

### توليد مفتاح SSH جديد (على جهازك المحلي أو الـ Droplet)

```bash
ssh-keygen -t ed25519 -C "github-actions-deploy" -f ~/.ssh/github_actions_key
```

سيُنشئ هذا الأمر ملفين:
- `~/.ssh/github_actions_key` — **المفتاح الخاص** (Private Key) — لا تشاركه مع أحد
- `~/.ssh/github_actions_key.pub` — **المفتاح العام** (Public Key)

### إضافة المفتاح العام إلى الـ Droplet

```bash
# نسخ المفتاح العام إلى الـ Droplet
ssh-copy-id -i ~/.ssh/github_actions_key.pub root@YOUR_DROPLET_IP

# أو يدوياً:
cat ~/.ssh/github_actions_key.pub >> ~/.ssh/authorized_keys
```

---

## 2. إعداد Secrets في GitHub

افتح ريبوزيتوري المشروع على GitHub، ثم اذهب إلى:
**Settings → Secrets and variables → Actions → New repository secret**

أضف الـ Secrets التالية:

| اسم الـ Secret | القيمة | مثال |
|---|---|---|
| `DROPLET_HOST` | عنوان IP الـ Droplet | `143.198.xxx.xxx` |
| `DROPLET_USER` | اسم المستخدم على الـ Droplet | `root` |
| `DROPLET_SSH_KEY` | محتوى المفتاح الخاص كاملاً | (انظر أدناه) |
| `DROPLET_PORT` | منفذ SSH | `22` |
| `DROPLET_PATH` | مسار مجلد المشروع | `/root/Telegroub-` |

### كيفية نسخ المفتاح الخاص

```bash
cat ~/.ssh/github_actions_key
```

انسخ المحتوى كاملاً بما في ذلك السطر الأول `-----BEGIN OPENSSH PRIVATE KEY-----` والأخير `-----END OPENSSH PRIVATE KEY-----` والصقه في قيمة الـ Secret.

---

## 3. إعداد الـ Droplet للمرة الأولى

### أ) إنشاء Droplet على DigitalOcean
- اختر **Ubuntu 22.04 LTS**
- الحجم المقترح: Basic — **$6/شهر** (1 GB RAM) يكفي لتشغيل البوت

### ب) تثبيت Docker على الـ Droplet

```bash
# الاتصال بالـ Droplet
ssh root@YOUR_DROPLET_IP

# تثبيت Docker بأمر واحد
curl -fsSL https://get.docker.com | sh

# التحقق من التثبيت
docker --version
docker compose version
```

### ج) استنساخ الريبو على الـ Droplet

```bash
git clone https://github.com/btygd543/Telegroub- /root/Telegroub-
cd /root/Telegroub-
```

### د) إنشاء ملف `config.env`

```bash
# نسخ ملف الإعدادات النموذجي
cp sample_config.env config.env

# تعديل القيم بمحرر nano
nano config.env
```

أدخل قيمك الحقيقية في الملف:

```dotenv
BOT_TOKEN=ضع_توكن_البوت_هنا
API_ID=ضع_api_id_هنا
API_HASH=ضع_api_hash_هنا
SESSION_STRING=ضع_session_string_هنا
SUDO_USERS_ID=ضع_ID_حسابك_هنا
LOG_GROUP_ID=ضع_ID_مجموعة_السجلات
MONGO_URL=ضع_رابط_mongodb_هنا
```

### هـ) تشغيل البوت للمرة الأولى

```bash
docker compose up -d --build
```

### و) التحقق من أن البوت يعمل

```bash
docker compose ps
docker compose logs -f
```

---

## 4. كيف يعمل النشر التلقائي؟

بعد إتمام الإعداد، في كل مرة تدفع (push) كوداً جديداً إلى الفرع `main` أو `master`:

1. ✅ GitHub Actions يبدأ تلقائياً
2. ✅ يتصل بالـ Droplet عبر SSH
3. ✅ يسحب آخر التغييرات بـ `git pull`
4. ✅ يعيد بناء البوت بـ `docker compose up -d --build`
5. ✅ يحذف الـ images القديمة بـ `docker image prune -f`
6. ✅ يتحقق من نجاح النشر بـ `docker compose ps`

يمكنك أيضاً تشغيل النشر يدوياً من:
**GitHub → Actions → Deploy to DigitalOcean Droplet → Run workflow**

---

## 5. استكشاف الأخطاء

```bash
# عرض سجلات البوت على الـ Droplet
docker compose logs -f

# إعادة تشغيل البوت يدوياً
docker compose restart

# إيقاف البوت
docker compose down

# التحقق من حالة الـ containers
docker compose ps
```
