<#-- Template Loading Page Graha Pusat Literasi -->
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle!"Loading Page - Graha Pusat Literasi"}</title>
    
    <#-- Framework & Google Fonts -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    
    <style>
        /* 1. DASAR TAMPILAN */
        body { 
            background-color: #1a1a1a; 
            margin: 0; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            height: 100vh; 
            overflow: hidden; 
        }
        .font-gelasio { font-family: 'Gelasio', serif; }

        /* 2. KANVAS UTAMA & LAYER DASAR (Natural Cream #F7F0CB) */
        #loading-canvas {
            width: 864px;
            height: 1536px;
            background-color: #F7F0CB; 
            position: relative;
            flex-shrink: 0;
            transform-origin: center center;
            box-shadow: 0 0 100px rgba(0,0,0,0.8);
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow: hidden;
        }

        /* 3. LAYER OVERLAY PUTIH 25% */
        #loading-canvas::before {
            content: "";
            position: absolute;
            inset: 0;
            background-color: #FFFFFF;
            opacity: 0.25;
            z-index: 1;
            pointer-events: none;
        }

        /* 4. LAYER GAMBAR WATERMARK (TETAP 230%) */
        #loading-canvas::after {
            content: "";
            position: absolute;
            inset: 0;
            z-index: 2;
            pointer-events: none;
            <#-- Jalur gambar dinamis -->
            background-image: url('${logoPath!"/images/frontoffice/logo.png"}'); 
            background-repeat: no-repeat;
            background-position: center center;
            background-size: 230% auto; 
            opacity: 0.20; 
            mix-blend-mode: multiply; 
            image-rendering: high-quality;
        }

        .z-content { 
            position: relative; 
            z-index: 10; 
            width: 100%; 
        }
    </style>
</head>
<body>

    <div id="loading-canvas">
        
        <#-- AREA TENGAH: PANDUAN (Posisi diturunkan sesuai permintaan) -->
        <div class="z-content flex-1 flex flex-col items-center justify-center text-center px-10 transform translate-y-[85px]">
            <#-- Judul dinamis (Default: Panduan) -->
            <h1 class="text-[#2A325F] text-[100px] font-bold font-lato tracking-[25px] uppercase drop-shadow-sm mb-6">
                ${content.title!"Panduan"}
            </h1>

            <p class="text-[#6B8A7A] text-4xl font-gelasio italic leading-tight mb-4">
                ${content.instruction!"Klik objek yang ada dalam gambar"}
            </p>
            <p class="text-[#2A325F] text-4xl font-gelasio">
                ${content.greeting!"Selamat Membaca"}
            </p>
        </div>

        <#-- AREA BAWAH: SALAM LITERASI (Posisi ditingkatkan agar pas di kapas) -->
        <div class="z-content mt-auto mb-[420px] flex flex-col items-center">
            <div class="bg-[#6B8A7A] bg-opacity-85 py-5 px-14 shadow-lg rounded-sm transition-transform hover:scale-105">
                <span class="text-white text-4xl font-gelasio tracking-[8px] uppercase">
                    ${content.slogan!"Salam Literasi"}
                </span>
            </div>
        </div>

    </div>

    <script>
        function updateLayout() {
            const canvas = document.getElementById('loading-canvas');
            const windowHeight = window.innerHeight;
            <#-- Skala dinamis berdasarkan tinggi kanvas 1536px -->
            const scale = windowHeight / 1536; 
            canvas.style.transform = `scale(${"$"}{scale})`;
        }
        window.addEventListener('load', updateLayout);
        window.addEventListener('resize', updateLayout);
    </script>

</body>
</html>