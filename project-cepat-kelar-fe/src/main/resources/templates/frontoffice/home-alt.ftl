<#-- Konfigurasi Path & URL -->
<#assign basePath = (basePath!"/images/frontoffice")>
<#assign pageTitle = "Lantai 2 - Graha Pusat Literasi Magetan">

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="/images/backoffice/Ellipse 2.png">
    <title>${pageTitle}</title>
    
    <link rel="preload" href="${basePath}/Latar2.png" as="image" fetchpriority="high">
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

        /* --- KANVAS UTAMA (KUNCI 1080x1920) --- */
        #homepage-canvas {
            width: 1080px !important; height: 1920px !important;
            background-color: #F7F3EE; 
            position: absolute; top: 50%; left: 50%;
            transform: translate(-50%, -50%) scale(1); transform-origin: center center;
            box-shadow: 0 0 100px rgba(0,0,0,0.8); overflow: hidden;
            will-change: transform;
        }

        .bg-illustration { position: absolute; inset: 0; width: 1080px !important; height: 1920px !important; max-width: none !important; object-fit: fill; z-index: 1; }

        /* --- ANIMASI CTA STRATEGIS (GOLDEN GLOW) --- */
        @keyframes heartbeatGlow {
            0%, 100% { filter: drop-shadow(0 0 8px rgba(255, 215, 0, 0.3)); } 
            50% { filter: drop-shadow(0 0 25px rgba(255, 200, 0, 0.7)); }
        }

        @keyframes scannerMove {
            0% { top: 10%; opacity: 0; }
            10%, 90% { opacity: 1; }
            100% { top: 85%; opacity: 0; }
        }

        .hotspot { 
            position: absolute; cursor: pointer; border: none; background: none; padding: 0; outline: none; 
            transition: transform 0.3s ease, filter 0.3s ease; 
            animation: heartbeatGlow 1.8s infinite ease-in-out;
        }
        
        .hotspot:hover { 
            transform: scale(1.03); 
            filter: drop-shadow(0 0 30px rgba(255, 180, 0, 0.9)); 
            animation-play-state: paused;
        }
        .hotspot:active { transform: scale(0.98); }

        .kedap-container { position: relative; width: 100%; height: 100%; overflow: hidden; z-index: 15; pointer-events: none; }
        .scanner-line {
            position: absolute; left: 15%; width: 70%; height: 4px;
            background: linear-gradient(90deg, transparent, #FFD700, transparent); 
            box-shadow: 0 0 15px #FFD700; z-index: 15;
            animation: scannerMove 3s infinite linear; pointer-events: none;
        }

        /* --- SISTEM OVERLAY / MODAL --- */
        .overlay-mask { position: fixed; inset: 0; background: rgba(0,0,0,0.85); display: none; justify-content: center; align-items: center; z-index: 9999; backdrop-filter: blur(8px); }
        .overlay-container { width: 90%; max-width: 800px; height: 85vh; background: #F7F3EE; border-radius: 30px; position: relative; overflow: hidden; display: none; flex-direction: column; border: 2px solid #D4AF37; /* Border Emas */ }
        .close-overlay { position: absolute; top: 20px; right: 20px; width: 45px; height: 45px; background: #D4AF37; color: #1a1a1a; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; z-index: 100; font-size: 20px; font-weight: bold; transition: background 0.3s; }
        .close-overlay:hover { background: #FFD700; }
        .content-scroll { padding: 40px; overflow-y: auto; flex-grow: 1; color: #333; }

        /* Z-Index Management */
        .layer-bg { z-index: 1; }
        .layer-belakang { z-index: 5; }
        .layer-tengah { z-index: 10; }
        .layer-depan { z-index: 20; } 
    </style>
</head>
<body>

    <div id="homepage-canvas">
        <img src="${basePath}/Latar2.png" alt="Interior Lantai 2" class="bg-illustration layer-bg" fetchpriority="high">

        <#-- 1. RAK ATAS (Koleksi -> Buka Overlay) -->
        <button class="hotspot w-[992px] h-[502px] left-[75px] top-[152px] layer-belakang" onclick="openOverlay('section-collections')">
            <img src="${basePath}/rak2.png" alt="Rak Atas" decoding="async" class="w-full h-full object-contain">
        </button>

        <#-- 2. SOUNDPROOF POD (Audio -> Buka Overlay) -->
        <button class="hotspot w-[488px] h-[647px] left-[499px] top-[765px] layer-belakang" onclick="openOverlay('section-audio')">
            <div class="absolute inset-0 z-5">
                <img src="${basePath}/headphone2.png" alt="Soundproof Pod" decoding="async" class="w-full h-full object-contain">
            </div>
            <div class="absolute inset-0 z-6 overflow-hidden">
                <div class="scanner-line"></div> 
            </div>
        </button>

        <#-- 3. RAK SAMPING (Statis) -->
        <img src="${basePath}/rakkanan.png" class="absolute w-[80px] h-[690px] left-[987px] top-[722px] layer-tengah pointer-events-none" alt="Rak Samping" decoding="async">

        <#-- 4. AREA BACA (Fasilitas -> Buka Overlay) -->
        <button class="hotspot w-[676.20px] h-[518.65px] left-[301px] top-[1181px] layer-tengah" onclick="openOverlay('section-facilities')">
            <img src="${basePath}/meja2.png" alt="Area Baca" decoding="async" class="w-full h-full object-contain">
        </button>

        <#-- 5. LIFT (Navigasi Beranda -> Pindah Halaman) -->
        <button class="hotspot w-[384px] h-[600px] left-[86px] top-[815px] layer-tengah" onclick="location.href='${berandaUrl! '/home'}'">
            <img src="${basePath}/lift2.png" alt="Lift" decoding="async" class="w-full h-full object-contain">
        </button>
        
        <#-- 6. KOTAK SUARA (Voting -> Buka Overlay) -->
        <button class="hotspot w-[240px] h-[384px] left-[857px] top-[1555px] layer-depan" onclick="openOverlay('section-voting')">
            <img src="${basePath}/kotaksuara2.png" alt="Kotak Suara" decoding="async" class="w-full h-full object-contain">
        </button>

        <#-- 7. TANAMAN (Statis) -->
        <img src="${basePath}/tanaman1.png" class="absolute w-[320px] h-[674px] left-0 top-[1218px] layer-depan pointer-events-none" alt="Tanaman" decoding="async">
    </div>

    <#-- ========================================================== -->
    <#-- SISTEM MODAL / OVERLAY LANTAI 2 -->
    <#-- ========================================================== -->
    <div id="overlay-mask" class="overlay-mask" onclick="closeAllOverlays()">
        
        <#-- Overlay Koleksi (Rak Atas) -->
        <div id="section-collections" class="overlay-container" onclick="event.stopPropagation()">
            <div class="close-overlay" onclick="closeAllOverlays()">✕</div>
            <div class="content-scroll">
                <#attempt><#include "collections.ftl"><#recover>
                    <h2 class="text-3xl font-bold text-[#D4AF37] mb-4">Katalog Koleksi</h2>
                    <p class="text-lg">Informasi buku dan literatur akan ditampilkan di sini.</p>
                </#attempt>
            </div>
        </div>

        <#-- Overlay Audio (Soundproof Pod) -->
        <div id="section-audio" class="overlay-container" onclick="event.stopPropagation()">
            <div class="close-overlay" onclick="closeAllOverlays()">✕</div>
            <div class="content-scroll">
                <#attempt><#include "audio.ftl"><#recover>
                    <h2 class="text-3xl font-bold text-[#D4AF37] mb-4">Audio & Podcast</h2>
                    <p class="text-lg">Dengarkan koleksi audiobook kami secara eksklusif.</p>
                </#attempt>
            </div>
        </div>

        <#-- Overlay Fasilitas (Area Baca) -->
        <div id="section-facilities" class="overlay-container" onclick="event.stopPropagation()">
            <div class="close-overlay" onclick="closeAllOverlays()">✕</div>
            <div class="content-scroll">
                <#attempt><#include "facilities.ftl"><#recover>
                    <h2 class="text-3xl font-bold text-[#D4AF37] mb-4">Fasilitas Ruang Baca</h2>
                    <p class="text-lg">Nikmati kenyamanan membaca di area fasilitas kami.</p>
                </#attempt>
            </div>
        </div>

        <#-- Overlay Voting (Kotak Suara) -->
        <div id="section-voting" class="overlay-container" onclick="event.stopPropagation()">
            <div class="close-overlay" onclick="closeAllOverlays()">✕</div>
            <div class="content-scroll">
                <#attempt><#include "voting.ftl"><#recover>
                    <h2 class="text-3xl font-bold text-[#D4AF37] mb-4">Ruang Aspirasi</h2>
                    <p class="text-lg">Berikan suara atau pendapat Anda untuk kemajuan literasi.</p>
                </#attempt>
            </div>
        </div>

    </div>

    <script>
        // --- Fungsi Buka/Tutup Overlay ---
        function openOverlay(id) { 
            document.getElementById('overlay-mask').style.display = 'flex'; 
            document.getElementById(id).style.display = 'flex'; 
        }
        function closeAllOverlays() { 
            document.getElementById('overlay-mask').style.display = 'none'; 
            const containers = document.querySelectorAll('.overlay-container'); 
            containers.forEach(c => c.style.display = 'none'); 
        }

        // --- Skala Dinamis Stabil (1080x1920) ---
        function scaleCanvas() {
            const canvas = document.getElementById('homepage-canvas');
            if (!canvas) return;
            const scale = Math.min(window.innerWidth / 1080, window.innerHeight / 1920);
            canvas.style.transform = "translate(-50%, -50%) scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
        setTimeout(scaleCanvas, 100); 
    </script>
</body>
</html>