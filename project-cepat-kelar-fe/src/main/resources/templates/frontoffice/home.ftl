<#-- Variabel Konfigurasi -->
<#assign basePath = (basePath!"/images/frontoffice")>
<#assign totemImages = ["sorotan12.png", "sorotan22.png"]>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="/images/backoffice/Ellipse 2.png">
    <title>${pageTitle! "Beranda - Graha Pusat Literasi Magetan"}</title>
    
    <link rel="preload" href="${basePath}/bg.png" as="image" fetchpriority="high">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700;900&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    
    <style>
        /* --- BASE & CANVAS (1080x1920 Kaku) --- */
        body { background-color: #1a1a1a; margin: 0; height: 100vh; overflow: hidden; font-family: 'Lato', sans-serif; position: relative; }

        #homepage-canvas {
            width: 1080px !important; height: 1920px !important;
            background-color: #F7F3EE; position: absolute; top: 50%; left: 50%;
            transform: translate(-50%, -50%) scale(1); transform-origin: center center;
            box-shadow: 0 0 100px rgba(0,0,0,0.8); overflow: hidden; z-index: 1;
            will-change: transform;
        }

        .bg-illustration { position: absolute; inset: 0; width: 1080px !important; height: 1920px !important; max-width: none !important; object-fit: fill; z-index: 1; }

        /* --- HOTSPOT & ANIMASI (GOLDEN GLOW - Konsisten dengan Lantai 2) --- */
        @keyframes heartbeatGlow {
            0%, 100% { filter: drop-shadow(0 0 8px rgba(255, 215, 0, 0.3)); } 
            50% { filter: drop-shadow(0 0 25px rgba(255, 200, 0, 0.7)); }
        }

        .hotspot { 
            position: absolute; z-index: 10; cursor: pointer; border: none; background: none; outline: none; 
            transition: transform 0.3s ease, filter 0.3s ease; 
            animation: heartbeatGlow 1.8s infinite ease-in-out; 
        }
        
        .hotspot:hover { 
            transform: scale(1.03); 
            filter: drop-shadow(0 0 30px rgba(255, 180, 0, 0.9)); 
            animation-play-state: paused;
        }
        .hotspot:active { transform: scale(0.98); }

        /* --- SISTEM OVERLAY / MODAL (UKURAN KAKU 864x1536) --- */
        .overlay-mask { 
            position: absolute; /* Mengikuti ukuran Kanvas 1080x1920 */
            inset: 0; 
            background: rgba(0,0,0,0.85); 
            display: none; justify-content: center; align-items: center; 
            z-index: 9999; backdrop-filter: blur(8px); 
        }
        .overlay-container { 
            width: 864px; height: 1536px; /* Proporsional 80% dari layar kiosk */
            background: #F7F3EE; border-radius: 40px; 
            position: relative; overflow: hidden; display: none; 
            flex-direction: column; border: 4px solid #3B5998; /* Tema Biru Lantai 1 */
            box-shadow: 0 0 50px rgba(0,0,0,0.5);
        }
        .close-overlay { 
            position: absolute; top: 30px; right: 30px; 
            width: 60px; height: 60px; 
            background: #3B5998; color: white; border-radius: 50%; 
            display: flex; align-items: center; justify-content: center; 
            cursor: pointer; z-index: 100; font-size: 30px; font-weight: bold; transition: background 0.3s; 
        }
        .close-overlay:hover { background: #2a4175; }
        .content-scroll { 
            padding: 50px; overflow-y: auto; flex-grow: 1; color: #333; 
            scrollbar-width: none; 
        }
        .content-scroll::-webkit-scrollbar { display: none; }
    </style>
</head>
<body>

    <div id="homepage-canvas">
        <img src="${basePath}/bg.png" alt="Interior Library" class="bg-illustration" fetchpriority="high">

        <#-- 1. TOTEM HIGHLIGHT -->
        <button class="hotspot w-[198px] h-[531px] left-[30px] top-[1300px]" onclick="openOverlay('section-highlights')">
            <div class="absolute bg-[#4A4A4A] z-[4] skew-y-[-26deg] rounded-[2px] flex items-center justify-center" 
                 style="top: 10%; left: 10%; width: 90%; height: 80%;">
                <span class="text-[#F7F3EE] font-black text-[22px] text-center uppercase tracking-[1px] leading-tight block transform -translate-y-3 translate-x-1">
                    #salam<br>literasi
                </span>
            </div>
            <img id="totem-screen" src="${basePath}/${totemImages[0]}" class="absolute object-cover transition-opacity duration-500" 
                 style="top: 3%; left: 10%; width: 90%; height: 86%; z-index: 5; filter: contrast(0.95) brightness(1.05);" alt="Content">
            <img src="${basePath}/sorotankosong2.png" class="absolute inset-0 z-10 pointer-events-none" alt="Frame">
        </button>

        <#-- 2. MEJA -->
        <button class="hotspot w-96 h-60 left-[305px] top-[1468px]" onclick="openOverlay('section-programs')">
            <img src="${basePath}/meja.png" alt="Meja">
        </button>

        <#-- 3. KALENDER -->
        <button class="hotspot w-72 h-64 left-[305px] top-[1203px]" onclick="openOverlay('section-events')">
            <img src="${basePath}/kalender.png" alt="Kalender">
        </button>
        
        <#-- 4. LIFT -->
        <button class="hotspot w-48 h-72 left-[635px] top-[1320px]" onclick="location.href='${lantaiUrl! '/home-alt'}'">
            <img src="${basePath}/lift.png" alt="Lift">
        </button>

        <#-- 5. FIGURA -->
        <button class="hotspot w-48 h-40 left-[861px] top-[1281px]" onclick="location.href='${galeriUrl! '/profile'}'">
            <img src="${basePath}/figura.png" alt="Figura">
        </button>

        <#-- 6. TROLI -->
        <button class="hotspot w-80 h-80 left-[825px] top-[1427px]" onclick="location.href='${beritaUrl! '/articles'}'">
            <img src="${basePath}/troli.png" alt="Troli">
        </button>


        <#-- ========================================================== -->
        <#-- SISTEM MODAL / OVERLAY LANTAI 1 (DI DALAM KANVAS) -->
        <#-- ========================================================== -->
        <div id="overlay-mask" class="overlay-mask" onclick="closeAllOverlays()">
            
            <#-- Overlay Sorotan -->
            <div id="section-highlights" class="overlay-container" onclick="event.stopPropagation()">
                <div class="close-overlay" onclick="closeAllOverlays()">&times;</div>
                <div class="content-scroll">
                    <#attempt><#include "highlights.ftl"><#recover>
                        <h2 class="text-3xl font-bold text-[#3B5998] mb-4">Sorotan</h2><p>Informasi segera hadir.</p>
                    </#attempt>
                </div>
            </div>

            <#-- Overlay Program -->
            <div id="section-programs" class="overlay-container" onclick="event.stopPropagation()">
                <div class="close-overlay" onclick="closeAllOverlays()">&times;</div>
                <div class="content-scroll">
                    <#attempt><#include "programs.ftl"><#recover>
                        <h2 class="text-3xl font-bold text-[#3B5998] mb-4">Layanan & Program</h2><p>Informasi segera hadir.</p>
                    </#attempt>
                </div>
            </div>

            <#-- Overlay Event -->
            <div id="section-events" class="overlay-container" onclick="event.stopPropagation()">
                <div class="close-overlay" onclick="closeAllOverlays()">&times;</div>
                <div class="content-scroll">
                    <#attempt><#include "events.ftl"><#recover>
                        <h2 class="text-3xl font-bold text-[#3B5998] mb-4">Agenda Mendatang</h2><p>Event segera diumumkan.</p>
                    </#attempt>
                </div>
            </div>

        </div> </div> <script>
        function openOverlay(id) { document.getElementById('overlay-mask').style.display = 'flex'; document.getElementById(id).style.display = 'flex'; }
        function closeAllOverlays() { document.getElementById('overlay-mask').style.display = 'none'; const containers = document.querySelectorAll('.overlay-container'); containers.forEach(c => c.style.display = 'none'); }

        function scaleCanvas() {
            const canvas = document.getElementById('homepage-canvas');
            if (!canvas) return;
            const scale = Math.min(window.innerWidth / 1080, window.innerHeight / 1920);
            canvas.style.transform = "translate(-50%, -50%) scale(" + scale + ")";
        }

        window.addEventListener('resize', scaleCanvas);
        window.addEventListener('DOMContentLoaded', scaleCanvas);
        setTimeout(scaleCanvas, 100);

        const screen = document.getElementById('totem-screen');
        const contents = [<#list totemImages as img>'${basePath}/${img}'<#if img_has_next>, </#if></#list>];
        let idx = 0;

        if (contents.length > 1) {
            setInterval(() => {
                if(!screen) return;
                screen.style.opacity = '0'; 
                setTimeout(() => {
                    idx = (idx + 1) % contents.length;
                    screen.src = contents[idx];
                    screen.onload = () => screen.style.opacity = '1';
                }, 500);
            }, 5500);
        }
    </script>
</body>
</html>