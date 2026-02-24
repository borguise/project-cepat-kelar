<#-- Konfigurasi Path & URL -->
<#assign basePath = r"${basePath!''}">
<#assign pageTitle = "Lantai 2 - Graha Pusat Literasi Magetan">

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    
    <style>
        /* --- OPTIMASI VISUAL & KETAJAMAN --- */
        body { 
            background-color: #1a1a1a; margin: 0; height: 100vh; overflow: hidden; 
            font-family: 'Lato', sans-serif; position: relative; 
            -webkit-font-smoothing: antialiased;
        }

        img {
            image-rendering: -webkit-optimize-contrast;
            image-rendering: crisp-edges;
            transform: translateZ(0); 
            backface-visibility: hidden;
        }

        #homepage-canvas {
            width: 1080px; height: 1920px;
            background-color: #F7F3EE; <#-- Natural Cream -->
            position: absolute; top: 50%; left: 50%;
            transform: translate(-50%, -50%); transform-origin: center center;
            box-shadow: 0 0 100px rgba(0,0,0,0.8); overflow: hidden;
            will-change: transform;
        }

        /* BG Tanpa Celah Putih */
        .bg-illustration { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: fill; z-index: 1; }

        /* --- ANIMASI CTA STRATEGIS --- */
        @keyframes heartbeatGlow {
            0%, 100% { filter: drop-shadow(0 0 5px rgba(59, 89, 152, 0.2)); } 
            50% { filter: drop-shadow(0 0 25px rgba(59, 89, 152, 0.8)); } <#-- Lake Blue -->
        }

        @keyframes scannerMove {
            0% { top: 10%; opacity: 0; }
            10%, 90% { opacity: 1; }
            100% { top: 85%; opacity: 0; }
        }

        .hotspot { position: absolute; cursor: pointer; border: none; background: none; padding: 0; outline: none; transition: transform 0.3s ease; }
        .hotspot img { animation: heartbeatGlow 2s infinite ease-in-out; transition: all 0.3s ease; }
        
        /* Hover & Active Feedback */
        .hotspot:hover img { 
            transform: scale(1.05); 
            filter: drop-shadow(0 0 35px rgba(59, 89, 152, 0.9)); 
        }
        .hotspot:active { transform: scale(0.95); }

        /* Scanner Kedap Suara */
        .kedap-container { position: relative; width: 100%; height: 100%; overflow: hidden; }
        .scanner-line {
            position: absolute; left: 15%; width: 70%; height: 4px;
            background: linear-gradient(90deg, transparent, #3B5998, transparent);
            box-shadow: 0 0 15px #3B5998; z-index: 15;
            animation: scannerMove 3s infinite linear; pointer-events: none;
        }

        /* Z-Index Management */
        .layer-bg { z-index: 1; }
        .layer-furnitur { z-index: 10; }
        .layer-depan { z-index: 20; pointer-events: none; } 
    </style>
</head>
<body>

    <div id="homepage-canvas">
        <#-- Prioritas muat tinggi untuk background -->
        <img src="${basePath}/Latar2.png" alt="Interior Lantai 2" class="bg-illustration layer-bg" fetchpriority="high">

        <#-- Aset Statis -->
        <img src="${basePath}/rakkanan.png" class="absolute w-[80px] h-[690px] left-[987px] top-[722px] layer-furnitur" alt="Rak Samping" decoding="async">

        <#-- 1. RAK ATAS (Pintu Koleksi) -->
        <button class="hotspot w-[992px] h-[502px] left-[75px] top-[152px] layer-furnitur" onclick="location.href='${koleksiUrl! 'koleksi.html'}'">
            <img src="${basePath}/rak2.png" alt="Rak Atas" decoding="async">
        </button>

        <#-- 2. LIFT (Navigasi Beranda & Anti-Mengambang) -->
        <button class="hotspot w-[384px] h-[600px] left-[86px] top-[815px] layer-furnitur" onclick="location.href='${berandaUrl! 'beranda.html'}'">
            <img src="${basePath}/lift2.png" alt="Lift" decoding="async">
        </button>

        <#-- 3. TANAMAN (Layer depan menutupi lift tanpa terpotong) -->
        <img src="${basePath}/tanaman1.png" class="absolute w-[320px] h-[674px] left-0 top-[1218px] layer-depan" alt="Tanaman" decoding="async">

        <#-- 4. SOUNDPROOF POD (Animasi Scanner Strategis) -->
        <button class="hotspot w-[488px] h-[647px] left-[499px] top-[765px] layer-furnitur" onclick="location.href='${audioUrl! 'Audio.html'}'">
            <div class="kedap-container">
                <div class="scanner-line"></div> 
                <img src="${basePath}/headphone2.png" alt="Soundproof Pod" decoding="async">
            </div>
        </button>

        <#-- Hotspots Lainnya -->
        <button class="hotspot w-[676.20px] h-[518.65px] left-[301px] top-[1181px] layer-furnitur" onclick="location.href='${fasilitasUrl! 'fasilitas.html'}'">
            <img src="${basePath}/meja2.png" alt="Area Baca" decoding="async">
        </button>
        <button class="hotspot w-[240px] h-[384px] left-[857px] top-[1555px] layer-furnitur" onclick="location.href='${pemilihanUrl! 'pemilihan.html'}'">
            <img src="${basePath}/kotaksuara2.png" alt="Kotak Suara" decoding="async">
        </button>
    </div>

    <script>
        <#-- Ultimate Centering Script -->
        function scaleCanvas() {
            const canvas = document.getElementById('homepage-canvas');
            const winW = window.innerWidth;
            const winH = window.innerHeight;
            const scale = Math.min(winW / 1080, winH / 1920);
            <#-- Penggunaan String Concatenation agar tidak bentrok dengan sintaks FTL -->
            canvas.style.transform = "translate(-50%, -50%) scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>