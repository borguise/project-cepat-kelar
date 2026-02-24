<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Fasilitas - Graha Pusat Literasi Magetan"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400&family=Gelasio:ital,wght@0,400;0,700;1,700&family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body { 
            background-color: #1a1a1a; margin: 0; padding: 0; 
            height: 100vh; width: 100vw; overflow: hidden; 
            display: flex; justify-content: center; align-items: center; 
        }

        /* KANVAS UTAMA: Terkunci 864x1536 */
        #fasilitas-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative;
            box-shadow: 0 0 120px rgba(0,0,0,0.6); 
            overflow: hidden;
            display: flex; flex-direction: column;
            transform-origin: center center;
        }

        .batik-overlay {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
            background-size: cover;
            opacity: 0.4; mix-blend-mode: multiply;
            pointer-events: none; z-index: 1;
        }

        .close-btn {
            position: absolute; top: 40px; right: 50px;
            font-size: 80px; color: #334155;
            cursor: pointer; z-index: 1000; line-height: 1;
            font-family: 'Inter', sans-serif;
        }

        .content-container {
            flex: 1; display: flex; flex-direction: column;
            justify-content: space-between; align-items: center;
            padding: 120px 40px 80px 40px; z-index: 10;
        }

        .header-section { text-align: center; }
        .title-fasilitas { font-family: 'Gelasio'; color: #334155; font-size: 85px; font-weight: bold; margin-bottom: 10px; }
        .subtitle-fasilitas { font-family: 'Gelasio'; color: #475569; font-size: 38px; font-weight: bold; }

        .carousel-outer { 
            position: relative; 
            width: 800px; 
            display: flex; align-items: center; justify-content: center; 
        }

        .carousel-frame {
            width: 720px; 
            height: 900px; 
            background-color: white;
            border-radius: 60px;
            border: 2px solid #000; 
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
        }

        .carousel-track {
            display: flex;
            overflow-x: auto;
            scroll-snap-type: x mandatory;
            scrollbar-width: none;
            height: 100%;
            scroll-behavior: smooth;
        }
        .carousel-track::-webkit-scrollbar { display: none; }

        .carousel-slide {
            min-width: 100%; height: 100%;
            scroll-snap-align: start;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            padding: 40px 60px; text-align: center;
        }

        .slide-judul { font-family: 'Gelasio'; font-size: 48px; color: #000; margin-bottom: 25px; font-weight: bold; }
        .slide-img { width: 100%; height: 450px; border-radius: 30px; object-fit: cover; margin-bottom: 35px; border: 1px solid #ddd; }
        .slide-caption { font-family: 'Lato'; font-size: 30px; color: #334155; line-height: 1.5; }

        .nav-arrow {
            position: absolute; top: 50%; transform: translateY(-50%);
            width: 80px; height: 80px;
            background-color: rgba(255, 255, 255, 0.9);
            border: 2px solid #334155; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 32px; color: #334155; cursor: pointer;
            z-index: 20;
        }
        .prev-arrow { left: -15px; }
        .next-arrow { right: -15px; }

        .footer-text {
            width: 780px; text-align: center;
            font-family: 'Lato'; font-size: 26px; color: #64748b; 
            line-height: 1.6; font-style: italic;
        }
    </style>
</head>
<body>

    <div id="fasilitas-canvas">
        <div class="batik-overlay"></div>
        
        <div class="close-btn" onclick="window.history.back()">×</div>

        <div class="content-container">
            <header class="header-section">
                <h1 class="title-fasilitas">${mainHeader!"Fasilitas"}</h1>
                <p class="subtitle-fasilitas">${subHeader!"Satu ruang, banyak inspirasi"}</p>
            </header>

            <div class="carousel-outer">
                <div class="nav-arrow prev-arrow" onclick="manualMove(-1)"><i class="fas fa-chevron-left"></i></div>
                <div class="nav-arrow next-arrow" onclick="manualMove(1)"><i class="fas fa-chevron-right"></i></div>

                <div class="carousel-frame">
                    <div class="carousel-track" id="carouselTrack">
                        <#-- LOOPING FASILITAS DINAMIS -->
                        <#if facilities??>
                            <#list facilities as f>
                                <div class="carousel-slide">
                                    <h2 class="slide-judul">${f.title}</h2>
                                    <img src="${f.imagePath}" class="slide-img" alt="${f.title}">
                                    <p class="slide-caption">${f.caption}</p>
                                </div>
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>

            <footer class="footer-text">
                ${footerText!"\"Perpustakaan bukan hanya tentang buku, tapi tentang bagaimana menciptakan ide menjadi kenyataan. Sebuah wadah bagi pribadi yang ingin terus berkembang.\""}
            </footer>
        </div>
    </div>

    <script>
        const track = document.getElementById('carouselTrack');
        const slides = document.querySelectorAll('.carousel-slide');
        let currentIndex = 0;
        const totalSlides = slides.length;
        let slideInterval;

        function manualMove(direction) {
            clearInterval(slideInterval);
            currentIndex += direction;
            if (currentIndex >= totalSlides) currentIndex = 0;
            if (currentIndex < 0) currentIndex = totalSlides - 1;
            updatePosition();
            startAutoSlide();
        }

        function updatePosition() {
            const width = track.offsetWidth;
            track.scrollTo({ left: currentIndex * width, behavior: 'smooth' });
        }

        function startAutoSlide() {
            slideInterval = setInterval(() => {
                if (totalSlides > 0) {
                    currentIndex = (currentIndex + 1) % totalSlides;
                    updatePosition();
                }
            }, 6000);
        }

        startAutoSlide();

        function scaleCanvas() {
            const canvas = document.getElementById('fasilitas-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>