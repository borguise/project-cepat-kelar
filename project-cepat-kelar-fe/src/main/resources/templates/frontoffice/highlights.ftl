<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Highlights - Graha Pusat Literasi Magetan"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400&family=Gelasio:ital,wght@0,400;0,700;1,700&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA: 864x1536 */
        #highlights-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; /* CREAM */
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 120px rgba(0,0,0,0.6);
        }

        .batik-overlay {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
            background-size: 500px;
            opacity: 0.6; mix-blend-mode: multiply;
            pointer-events: none; z-index: 1;
        }

        /* AREA GULIR: Scrollbar Tersembunyi */
        .content-scroll {
            flex: 1; overflow-y: auto;
            padding: 0 90px; 
            z-index: 10;
            scrollbar-width: none; 
            scroll-behavior: smooth;
        }
        .content-scroll::-webkit-scrollbar { display: none; }

        /* HEADER: Menampung Tombol Silang Statis */
        .header-section {
            position: relative; padding-top: 150px; text-align: center; margin-bottom: 90px;
        }

        /* TOMBOL KELUAR: Proporsional (60px) & Statis */
        .close-btn {
            position: absolute; top: 30px; right: -30px;
            font-size: 60px; color: #334155;
            cursor: pointer; line-height: 1; font-family: 'Inter', sans-serif;
            z-index: 100;
        }

        .title-highlights { font-family: 'Gelasio'; color: #334155; font-size: 96px; font-weight: bold; margin-bottom: 40px; }
        .subtitle-highlights { font-family: 'Gelasio'; color: rgba(51, 65, 85, 0.85); font-size: 32px; font-weight: bold; line-height: 1.6; max-width: 680px; margin: 0 auto; }

        /* FAQ LIST: Tanpa Garis Pemisah */
        .faq-container { width: 100%; margin-bottom: 60px; }

        .faq-row {
            width: 100%;
            background-color: rgba(255, 255, 255, 0.45); 
            backdrop-filter: blur(5px);
            padding: 40px 30px;
            display: flex; align-items: center; gap: 30px;
            cursor: pointer;
            margin-bottom: 30px; 
            border-radius: 12px;
        }

        /* ANIMASI IKON MORPHING */
        .faq-icon-box {
            width: 40px; height: 40px; position: relative;
            display: flex; justify-content: center; align-items: center;
        }
        .faq-icon-box::before {
            content: ''; position: absolute;
            width: 30px; height: 5px; background-color: #334155;
            border-radius: 2px; transition: all 300ms ease;
        }
        .faq-icon-box::after {
            content: ''; position: absolute;
            width: 5px; height: 30px; background-color: #334155;
            border-radius: 2px; transition: all 300ms ease-in-out;
        }
        .faq-row.active .faq-icon-box::after { transform: rotate(90deg); opacity: 0; }

        /* KONSISTENSI FONT: 32px & 26px */
        .faq-question { 
            font-family: 'Gelasio'; font-size: 32px; font-weight: bold; color: #334155; 
            text-align: center; flex: 1; line-height: 1.4; 
        }

        .faq-body {
            display: grid; grid-template-rows: 0fr;
            transition: all 400ms cubic-bezier(0.4, 0, 0.2, 1);
        }
        .active + .faq-body { grid-template-rows: 1fr; margin-bottom: 50px; }

        .faq-content { overflow: hidden; padding: 0 20px; }
        .faq-text { 
            color: #475569; font-family: 'Lato', sans-serif; 
            font-size: 26px; line-height: 1.7; text-align: center; 
            font-style: italic; font-weight: 600;
        }

        /* FOOTER */
        .footer-highlights {
            padding: 80px 0 200px 0; text-align: center; display: flex; flex-direction: column; align-items: center; gap: 70px;
        }
        .footer-desc { font-family: 'Gelasio'; color: rgba(51, 65, 85, 0.85); font-size: 32px; font-weight: bold; line-height: 1.6; max-width: 650px; }
        .social-icons { display: flex; gap: 110px; }
        .social-icons i { font-size: 130px; color: #334155; }
    </style>
</head>
<body>

    <div id="highlights-canvas">
        <div class="batik-overlay"></div>
        
        <div class="content-scroll">
            <header class="header-section">
                <div class="close-btn" onclick="window.history.back()">X</div>
                <h1 class="title-highlights">${mainTitle!"Highlights"}</h1>
                <p class="subtitle-highlights">${subTitle!"Pertanyaanmu penting, dan kami siap menjawab pertanyaan mu disini."}</p>
            </header>

            <div class="faq-container">
                <#if faqs??>
                    <#list faqs as faq>
                        <div class="faq-row" onclick="this.classList.toggle('active')">
                            <div class="faq-icon-box"></div>
                            <div class="faq-question">${faq.question}</div>
                        </div>
                        <div class="faq-body">
                            <div class="faq-content">
                                <p class="faq-text">${faq.answer}</p>
                            </div>
                        </div>
                    </#list>
                </#if>
            </div>

            <footer class="footer-highlights">
                <p class="footer-desc">${footerDesc!"Masih belum menemukan jawaban yang kamu suka? atau kamu memrlukan informasi tambahan?"}</p>
                <div class="social-icons">
                    <a href="${whatsappLink!"#"}"><i class="fab fa-whatsapp"></i></a>
                    <a href="${instagramLink!"#"}"><i class="fab fa-instagram"></i></a>
                </div>
            </footer>
        </div>
    </div>

    <script>
        function scaleCanvas() {
            const canvas = document.getElementById('highlights-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>