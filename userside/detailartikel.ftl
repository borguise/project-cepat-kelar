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

        /* KANVAS UTAMA: Cream Figma #f7f0cb */
        #article-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 120px rgba(0,0,0,0.6);
            transform-origin: center center;
        }

        .batik-overlay {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"batikspring.png"}'); 
            background-size: 500px;
            opacity: 0.55; mix-blend-mode: multiply;
            pointer-events: none; z-index: 1;
        }

        /* Navigasi X Cerdas */
        .close-btn {
            position: absolute; top: 40px; right: 50px;
            font-size: 60px; color: #1F1F1F;
            cursor: pointer; z-index: 1000; font-family: 'Inter', sans-serif;
            transition: opacity 0.4s ease, visibility 0.4s;
        }

        .content-scroll {
            flex: 1; overflow-y: auto;
            padding: 50px 32px; z-index: 10;
            scrollbar-width: none;
            scroll-behavior: smooth;
        }
        .content-scroll::-webkit-scrollbar { display: none; }

        /* WRAPPER KONTEN */
        .article-wrapper {
            background-color: #ffffff; border-radius: 32px;
            padding: 60px 40px; display: flex; flex-direction: column;
            align-items: center; gap: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.02);
            margin-bottom: 50px;
        }

        .back-link { font-family: 'Lato', sans-serif; color: #7dd3fc; font-size: 24px; cursor: pointer; text-decoration: none; }
        .article-title { font-family: 'Gelasio', serif; color: rgba(51, 65, 85, 0.75); font-size: 48px; font-weight: bold; text-align: center; }
        .main-img { width: 100%; height: 450px; object-fit: cover; border-radius: 20px; }
        
        /* Teks Narasi Berwarna Indigo-800 Sesuai Figma */
        .body-text { font-family: 'Gelasio', serif; color: #3730a3; font-size: 26px; font-weight: bold; line-height: 1.8; text-align: center; }

        /* SEKSI KOMENTAR ABU-ABU */
        .comment-box-grey {
            width: 100%; background-color: #e5e7eb; border-radius: 24px;
            padding: 40px; display: flex; flex-direction: column; gap: 20px;
        }
        .input-white {
            width: 100%; background: white; border-radius: 16px;
            padding: 24px; font-family: 'Gelasio', serif; font-size: 24px;
            border: none; text-align: center; outline: none;
        }
        .textarea-white {
            width: 100%; height: 220px; background: white; border-radius: 16px;
            padding: 24px; font-family: 'Lato', sans-serif; font-size: 24px;
            border: none; text-align: center; resize: none; outline: none;
        }

        .comment-item { display: flex; gap: 20px; align-items: flex-start; margin-top: 25px; width: 100%; }
        .user-icon { width: 50px; height: 50px; display: flex; justify-content: center; align-items: center; color: #1F1F1F; font-size: 24px; }
        .comment-details { flex: 1; text-align: left; display: flex; gap: 30px; border-bottom: 1px solid rgba(0,0,0,0.05); padding-bottom: 16px; }
        .user-name { font-family: 'Lato', sans-serif; font-size: 24px; color: #1F1F1F; min-width: 120px; }
        .user-msg { font-family: 'Gelasio', serif; font-size: 26px; font-weight: bold; color: #1F1F1F; flex: 1; }
    </style>
</head>
<body>

    <div id="article-canvas">
        <div class="batik-overlay"></div>
        <div id="dynamicCloseBtn" class="close-btn" onclick="window.history.back()">x</div>

        <div id="scrollArea" class="content-scroll">
            
            <div class="article-wrapper">
                <a href="${backUrl!"#"}" class="back-link">&lt; Kembali ke daftar berita</a>
                
                <h1 class="article-title">${articleTitle!"Memori Milik Kita"}</h1>
                
                <img src="${articleImage!"https://placehold.co/752x421"}" class="main-img" alt="Header">

                <div class="body-text">
                    <#-- Konten Teks Utuh -->
                    ${articleContent!"Isi artikel tidak ditemukan."}
                </div>

                <#-- SEKSI KOMENTAR -->
                <form action="${commentAction!"#"}" method="POST" class="comment-box-grey">
                    <input type="email" name="email" placeholder="Email" class="input-white" required>
                    <input type="password" name="password" placeholder="Password" class="input-white" required>
                    <div class="relative">
                        <textarea name="comment" placeholder="Tuliskan Komentar anda disini" class="textarea-white" required></textarea>
                        <button type="submit" class="absolute bottom-6 right-6 text-indigo-800 text-4xl hover:scale-110 transition-transform">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>

                    <div class="mt-10 space-y-4">
                        <#if comments??>
                            <#list comments as c>
                                <div class="comment-item">
                                    <div class="user-icon"><i class="fas fa-user"></i></div>
                                    <div class="comment-details">
                                        <span class="user-name">${c.userName}</span>
                                        <span class="user-msg">${c.text}</span>
                                    </div>
                                </div>
                            </#list>
                        <#else>
                            <#-- Tampilan Default jika belum ada komentar -->
                            <div class="comment-item">
                                <div class="user-icon"><i class="fas fa-user"></i></div>
                                <div class="comment-details">
                                    <span class="user-name">Nama</span>
                                    <span class="user-msg">isi komentar</span>
                                </div>
                            </div>
                        </#if>
                    </div>
                </form>

                <div class="w-full h-px bg-gray-400 opacity-30 mt-10"></div>
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