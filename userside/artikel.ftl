<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Detail Artikel - Graha Pusat Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA */
        #article-canvas {
            width: 864px; height: 1536px;
            background-color: #f5f5f4; 
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 120px rgba(0,0,0,0.6);
            transform-origin: center center;
        }

        /* TOMBOL KELUAR: Dinamis Menghilang */
        .close-btn {
            position: absolute; top: 40px; right: 50px;
            font-size: 60px; color: #1F1F1F;
            cursor: pointer; z-index: 1000; font-family: 'Inter', sans-serif;
            transition: opacity 0.4s ease, visibility 0.4s;
        }

        /* AREA GULIR */
        .content-scroll {
            flex: 1; overflow-y: auto;
            padding: 50px 32px; z-index: 10;
            scrollbar-width: none;
            scroll-behavior: smooth;
        }
        .content-scroll::-webkit-scrollbar { display: none; }

        /* WRAPPER KONTEN PUTIH */
        .article-wrapper {
            background-color: #ffffff; border-radius: 32px;
            padding: 60px 40px; display: flex; flex-direction: column;
            align-items: center; gap: 40px;
            margin-bottom: 50px;
        }

        .back-link { font-family: 'Lato', sans-serif; color: #7dd3fc; font-size: 24px; text-decoration: none; }
        .article-title { font-family: 'Gelasio', serif; color: rgba(51, 65, 85, 0.75); font-size: 48px; font-weight: bold; text-align: center; }
        .main-img { width: 100%; height: 450px; object-fit: cover; border-radius: 16px; }

        /* TEKS ARTIKEL: Indigo-800 */
        .body-text { 
            font-family: 'Gelasio', serif; color: #3730a3; font-size: 26px; 
            font-weight: bold; line-height: 1.8; text-align: center; 
        }

        /* SEKSI KOMENTAR */
        .comment-section {
            width: 100%; background-color: #d4d4d8; border-radius: 24px;
            padding: 40px; display: flex; flex-direction: column; gap: 30px;
        }
        .input-field {
            width: 100%; background: white; border-radius: 16px;
            padding: 20px; font-family: 'Gelasio', serif; font-size: 24px;
            border: none; text-align: center;
        }
        .textarea-field {
            width: 100%; height: 200px; background: white; border-radius: 16px;
            padding: 20px; font-family: 'Lato', sans-serif; font-size: 24px;
            border: none; text-align: center; resize: none;
        }

        .comment-item { display: flex; gap: 20px; align-items: flex-start; margin-top: 20px; }
        .avatar { width: 60px; height: 60px; border-radius: 50%; background: #e5e7eb; flex-shrink: 0; }
        .user-name { font-family: 'Lato', sans-serif; font-size: 22px; color: #1F1F1F; }
        .user-text { font-family: 'Gelasio', serif; font-size: 24px; font-weight: bold; color: #1F1F1F; }
    </style>
</head>
<body>

    <div id="article-canvas">
        <div id="dynamicCloseBtn" class="close-btn" onclick="window.history.back()">x</div>

        <div id="scrollArea" class="content-scroll">
            
            <div class="article-wrapper">
                <a href="${backUrl!"#"}" class="back-link">&lt; Kembali ke daftar berita</a>
                
                <h1 class="article-title">${article.title!"Judul Artikel"}</h1>
                
                <#if article.image??>
                    <img src="${article.image}" class="main-img" alt="Header">
                <#else>
                    <img src="https://placehold.co/752x421" class="main-img">
                </#if>

                <div class="body-text">
                    ${article.content!"Isi artikel tidak ditemukan."}
                </div>

                <#-- SEKSI KOMENTAR -->
                <div class="comment-section">
                    <form action="${commentAction!"#"}" method="POST" class="flex flex-col gap-6">
                        <input type="email" name="email" placeholder="Email" class="input-field" required>
                        <input type="password" name="password" placeholder="Password" class="input-field" required>
                        <div class="relative">
                            <textarea name="comment" placeholder="Tuliskan Komentar anda disini" class="textarea-field" required></textarea>
                            <button type="submit" class="absolute bottom-4 right-4 text-indigo-800 text-3xl"><i class="fas fa-paper-plane"></i></button>
                        </div>
                    </form>

                    <div class="mt-8 space-y-6">
                        <#if comments??>
                            <#list comments as c>
                                <div class="comment-item">
                                    <div class="avatar">
                                        <#if c.avatar??><img src="${c.avatar}" class="rounded-full w-full h-full"></#if>
                                    </div>
                                    <div class="text-left">
                                        <div class="user-name">${c.userName}</div>
                                        <div class="user-text">${c.text}</div>
                                    </div>
                                </div>
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        const scrollArea = document.getElementById('scrollArea');
        const closeBtn = document.getElementById('dynamicCloseBtn');

        scrollArea.addEventListener('scroll', () => {
            if (scrollArea.scrollTop > 80) {
                closeBtn.style.opacity = '0';
                closeBtn.style.visibility = 'hidden';
            } else {
                closeBtn.style.opacity = '1';
                closeBtn.style.visibility = 'visible';
            }
        });

        function scaleCanvas() {
            const canvas = document.getElementById('article-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>