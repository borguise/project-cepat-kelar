<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Layanan - Graha Pusat Literasi Magetan"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400&family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS OVERLAY: 864x1536 */
        #overlay-layanan {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; /* CREAM */
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 100px rgba(0,0,0,0.6);
        }

        /* BATIK PRING TEGAS */
        .batik-overlay {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
            background-size: 500px;
            opacity: 0.6; mix-blend-mode: multiply;
            pointer-events: none; z-index: 1;
        }

        .scroll-wrapper {
            width: 100%; height: 100%;
            overflow-y: auto; padding: 0 40px;
            z-index: 10; scrollbar-width: none;
            scroll-behavior: smooth;
        }
        .scroll-wrapper::-webkit-scrollbar { display: none; }

        /* NAVIGASI (IKUT SCROLL) */
        .scrollable-nav { 
            position: relative; padding-top: 140px; 
            text-align: center; margin-bottom: 60px; 
        }

        .close-btn {
            position: absolute; top: 40px; right: 20px; 
            font-size: 70px; color: #1a1a1a;
            cursor: pointer; line-height: 1; font-family: 'Inter', sans-serif;
        }

        .main-title { 
            font-family: 'Inter'; font-size: 38px; font-weight: 900; color: #1a1a1a; 
            line-height: 1.3; margin-bottom: 50px; padding: 0 50px;
        }
        
        .tab-container {
            display: inline-flex; background-color: #3730a3; 
            padding: 5px; border-radius: 12px; gap: 8px;
        }
        .tab-button {
            width: 165px; height: 44px; display: flex; align-items: center; justify-content: center;
            border-radius: 10px; font-family: 'Lato'; font-size: 24px; color: white;
            text-decoration: none;
        }
        .tab-button.active { font-weight: bold; background-color: rgba(255,255,255,0.2); }

        /* PEMISAH HIJAU BAMBU */
        .thin-separator {
            border-top: 2px solid #6B8A7A; /* HIJAU BAMBU */
            width: 85%; margin: 0 auto;
            opacity: 0.6;
        }

        /* UNIT LAYANAN SEAMLESS ZIGZAG */
        .service-unit {
            display: flex; align-items: center; gap: 40px;
            margin: 80px 0; position: relative;
        }
        .service-unit.reverse { flex-direction: row-reverse; }

        /* TEKS RATA TENGAH */
        .service-text { 
            flex: 1; display: flex; flex-direction: column; 
            gap: 15px; text-align: center; align-items: center; 
        }

        .service-title { font-family: 'Inter'; font-size: 32px; font-weight: 900; color: #000; }
        .service-desc { font-family: 'Inter'; font-size: 26px; color: #1a1a1a; line-height: 1.4; font-weight: 600; }
        .service-link { font-family: 'Inter'; font-size: 26px; color: #3730a3; font-weight: 800; text-decoration: underline; }

        .service-img { 
            width: 260px; height: 320px; 
            border-radius: 40px; object-fit: cover; 
            box-shadow: 0 15px 30px rgba(0,0,0,0.12);
        }

        .scroll-footer { height: 250px; }

        .scroll-hint {
            position: absolute; bottom: 50px; left: 50%; transform: translateX(-50%);
            z-index: 1500; cursor: pointer; transition: opacity 0.5s ease;
        }
        .arrow-icon { font-size: 70px; color: #1a1a1a; opacity: 0.7; animation: bounce 2s infinite; }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
            40% {transform: translateY(-25px);}
        }
    </style>
</head>
<body>

    <div id="overlay-layanan">
        <div class="batik-overlay"></div>
        
        <div class="scroll-wrapper" id="scrollArea">
            
            <header class="scrollable-nav">
                <div class="close-btn" onclick="window.history.back()">x</div>
                <h1 class="main-title">${mainTitle!"Layanan - layanan untuk pengunjung<br>Graha Pusat Literasi Kabupaten Magetan"}</h1>
                <nav class="tab-container">
                    <a href="${layananLink!"#"}" class="tab-button active">Layanan</a>
                    <a href="${kegiatanLink!"#"}" class="tab-button">Kegiatan</a>
                </nav>
            </header>

            <div class="thin-separator" style="margin-bottom: 40px;"></div>

            <#if services??>
                <#list services as service>
                    <div class="service-unit ${((service?index % 2) == 0)?string('reverse', '')}">
                        <img src="${service.imagePath}" class="service-img" alt="${service.title}">
                        <div class="service-text">
                            <h2 class="service-title">${service.title}</h2>
                            <p class="service-desc">${service.description}</p>
                            <a href="${service.detailLink!"#"}" class="service-link">${service.linkText!"Baca ceritanya di sini."}</a>
                        </div>
                    </div>
                    <#if service?has_next>
                        <div class="thin-separator"></div>
                    </#if>
                </#list>
            </#if>

            <div class="scroll-footer"></div>
        </div>

        <div class="scroll-hint" id="scrollHint" onclick="scrollDown()">
            <i class="fas fa-chevron-down arrow-icon"></i>
        </div>
    </div>

    <script>
        const scrollArea = document.getElementById('scrollArea');
        const scrollHint = document.getElementById('scrollHint');

        function scrollDown() {
            scrollArea.scrollBy({ top: 450, behavior: 'smooth' });
        }

        scrollArea.addEventListener('scroll', () => {
            const isAtBottom = scrollArea.scrollHeight - scrollArea.scrollTop <= scrollArea.clientHeight + 100;
            if (scrollArea.scrollTop > 80 || isAtBottom) {
                scrollHint.style.opacity = '0';
                scrollHint.style.pointerEvents = 'none';
            } else {
                scrollHint.style.opacity = '0.7';
                scrollHint.style.pointerEvents = 'auto';
            }
        });

        function scaleCanvas() {
            const canvas = document.getElementById('overlay-layanan');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>