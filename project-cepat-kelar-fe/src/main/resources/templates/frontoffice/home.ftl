<#-- Variabel Konfigurasi -->
<#assign basePath = (basePath!"/images/frontoffice")>
<#assign totemImages = ["sorotan12.png", "sorotan22.png"]>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle! "Beranda - Graha Pusat Literasi Magetan"}</title>
    
    <#-- Preload Background & Gambar Utama untuk LCP Cepat -->
    <link rel="preload" href="${basePath}/bg.png" as="image" fetchpriority="high">
    <link rel="preload" href="${basePath}/${totemImages[0]}" as="image" fetchpriority="high">

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    
    <style>
        /* --- OPTIMASI RENDER & GPU --- */
        body { 
            background-color: #1a1a1a; margin: 0; height: 100vh; overflow: hidden; 
            font-family: 'Lato', sans-serif; position: relative; 
            -webkit-font-smoothing: antialiased; 
        }

        img {
            image-rendering: -webkit-optimize-contrast;
            image-rendering: crisp-edges;
            transform: translateZ(0); /* Memaksa GPU rendering */
            backface-visibility: hidden;
        }

        #homepage-canvas {
            width: 1080px; height: 1920px;
            background-color: #F7F3EE; /* Natural Cream */
            position: absolute; top: 50%; left: 50%;
            transform: translate(-50%, -50%); transform-origin: center center;
            box-shadow: 0 0 100px rgba(0,0,0,0.8); overflow: hidden;
            will-change: transform;
        }

        .bg-illustration { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: fill; z-index: 1; }

        /* --- HEARTBEAT GLOW (Lake Blue #3B5998) --- */
        @keyframes heartbeatGlow {
            0%, 100% { filter: drop-shadow(0 0 5px rgba(59, 89, 152, 0.2)); } 
            50% { filter: drop-shadow(0 0 25px rgba(59, 89, 152, 0.7)); }
        }

        .hotspot { 
            position: absolute; z-index: 10; cursor: pointer; border: none; 
            background: none; padding: 0; outline: none; transition: transform 0.3s ease;
        }
        
        .hotspot img { animation: heartbeatGlow 2s infinite ease-in-out; }
        .hotspot:hover img { transform: scale(1.05); filter: drop-shadow(0 0 30px rgba(59, 89, 152, 0.9)); }
        .hotspot:active { transform: scale(0.92); filter: brightness(0.8); }

        /* --- LOGIKA LAYAR TOTEM --- */
        .totem-btn { background-color: transparent !important; }

        .totem-white-base {
            position: absolute;
            background-color: #5C5C5C; /* Stone Gray */
            z-index: 4;
            transform: skewY(-26deg); 
            border-radius: 2px;
            display: flex; align-items: center; justify-content: center;
            padding-left: 12px; 
        }

        .totem-label {
            color: #F7F3EE; font-family: 'Gelasio', serif; 
            font-weight: bold; font-size: 14px; text-align: center;
            line-height: 1.2; text-transform: uppercase;
            pointer-events: none; letter-spacing: 1px;
        }

        .totem-img-content { position: absolute; z-index: 5; object-fit: cover; transition: opacity 0.5s; }
        .totem-img-frame { position: absolute; inset: 0; z-index: 10; pointer-events: none; }
    </style>
</head>
<body>

    <div id="homepage-canvas">
        <#-- Prioritas muat tinggi untuk background -->
        <img src="${basePath}/bg.png" alt="Interior Library" class="bg-illustration" fetchpriority="high">

        <#-- 1. TOTEM HIGHLIGHT -->
        <button class="hotspot totem-btn w-[198px] h-[531px] left-[30px] top-[1300px]" onclick="location.href='${infoUrl! '/highlights'}'">
            <div class="totem-white-base" style="top: 10%; left: 11%; width: 80%; height: 80%;">
                <span class="totem-label">#salam literasi</span>
            </div>
            
            <img id="totem-screen" src="${basePath}/${totemImages[0]}" class="totem-img-content" style="top: 3%; left: 10%; width: 90%; height: 86%;" alt="Content" fetchpriority="high">
            
            <img src="${basePath}/highlightskosong2.png" class="totem-img-frame" alt="Frame" decoding="async">
        </button>

        <#-- 2. HOTSPOT LAINNYA (Menggunakan decoding="async" agar tidak menghambat main thread) -->
        <button class="hotspot w-96 h-60 left-[305px] top-[1468px]" onclick="location.href='${layananUrl! '/programs'}'"><img src="${basePath}/meja.png" alt="Meja" decoding="async"></button>
        <button class="hotspot w-72 h-64 left-[305px] top-[1203px]" onclick="location.href='${eventUrl! '/events'}'"><img src="${basePath}/kalender.png" alt="Kalender" decoding="async"></button>
        <button class="hotspot w-48 h-72 left-[635px] top-[1320px]" onclick="location.href='${lantaiUrl! '/home-alt'}'"><img src="${basePath}/lift.png" alt="Lift" decoding="async"></button>
        <button class="hotspot w-48 h-40 left-[861px] top-[1281px]" onclick="location.href='${galeriUrl! '/profile'}'"><img src="${basePath}/figura.png" alt="Figura" decoding="async"></button>
        <button class="hotspot w-80 h-80 left-[825px] top-[1427px]" onclick="location.href='${beritaUrl! '/articles'}'"><img src="${basePath}/troli.png" alt="Troli" decoding="async"></button>
    </div>

    <script>
        // Skala Dinamis Teroptimasi
        function scaleCanvas() {
            const canvas = document.getElementById('homepage-canvas');
            const scale = Math.min(window.innerWidth / 1080, window.innerHeight / 1920);
            canvas.style.transform = "translate(-50%, -50%) scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);

        // Pre-caching & Carousel Teroptimasi
        const contents = [<#list totemImages as img>'${basePath}/${img}'<#if img_has_next>, </#if></#list>];
        
        // Memaksa browser mengunduh gambar carousel di latar belakang
        contents.forEach(src => { const img = new Image(); img.src = src; });

        const screen = document.getElementById('totem-screen');
        let idx = 0;

        setInterval(() => {
            screen.style.opacity = '0'; 
            setTimeout(() => {
                idx = (idx + 1) % contents.length;
                screen.src = contents[idx];
                // Menunggu gambar benar-benar termuat sebelum memunculkan kembali
                screen.onload = () => screen.style.opacity = '1';
            }, 500);
        }, 5000);
    </script>
</body>
</html>