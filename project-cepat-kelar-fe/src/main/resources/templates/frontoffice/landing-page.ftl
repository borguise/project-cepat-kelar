<#-- Template Landing Page Graha Pusat Literasi -->
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle!"Landing - Graha Pusat Literasi Magetan"}</title>
    
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

        /* 2. KANVAS UTAMA (1080x1920) */
        #canvas {
            width: 1080px;
            height: 1920px;
            background-color: #F7F0CB; <#-- Natural Cream -->
            position: relative;
            flex-shrink: 0;
            transform-origin: center center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 0 100px rgba(0,0,0,0.8);
        }

        /* 3. LAPISAN TEKSTUR 20% */
        #canvas::before {
            content: "";
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background-image: url('${texturePath!"/images/frontoffice/tekstur-kertas.jpg"}'); 
            background-size: cover;
            background-repeat: no-repeat;
            opacity: 0.2; 
            mix-blend-mode: multiply; 
            pointer-events: none; 
            z-index: 0;
        }

        /* Konten di atas tekstur */
        header, main, footer { position: relative; z-index: 10; }

        <#-- Palet Warna Magetan -->
        .text-deep-blue { color: #2A325F; }
        .text-bamboo-green { color: #8F9F8F; }
        .bg-bamboo-green { background-color: #8F9F8F; }

        @keyframes breathing {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        .animate-napas { animation: breathing 3s infinite ease-in-out; }
    </style>
</head>
<body>

    <div id="canvas">
        
        <#-- HEADER: Dinaikkan dengan pt-40 -->
        <header class="w-full pt-40 px-20 flex items-center">
            <#-- Logo menyatu dengan background tanpa box putih -->
            <div class="w-32 h-32 flex items-center justify-center overflow-hidden">
                <img src="${logoPath!"/images/frontoffice/logo.png"}" alt="Logo" class="w-full h-full object-contain mix-blend-multiply">
            </div>
            <div class="ml-8 text-deep-blue font-lato italic text-4xl tracking-widest font-medium">
                ${content.slogan!"Salam literasi"}
            </div>
        </header>

        <#-- MAIN: Teks dinaikkan secara proporsional (-mt-32) -->
        <main class="flex-1 flex flex-col items-center justify-center text-center px-10 -mt-32">
            <div class="w-full max-w-[800px] h-[2px] bg-deep-blue/10 mb-20"></div>
            <h2 class="text-deep-blue font-bold uppercase tracking-[0.5em] text-4xl mb-6">
                ${content.titlePart1!"GRAHA PUSAT"}
            </h2>
            <h1 class="font-gelasio text-bamboo-green text-[180px] italic tracking-tight leading-none">
                ${content.titlePart2!"LITERASI"}
            </h1>
            <h2 class="text-deep-blue font-gelasio uppercase tracking-[0.4em] text-5xl mt-10">
                ${content.titlePart3!"KABUPATEN MAGETAN"}
            </h2>
        </main>

        <#-- FOOTER: Tombol dinaikkan dengan pb-80 (320px dari bawah) -->
        <footer class="pb-80 flex justify-center">
            <a href="${content.buttonUrl!"/home"}" 
               class="animate-napas inline-block transform bg-bamboo-green text-stone-100 font-gelasio text-4xl tracking-[0.2em] px-24 py-8 rounded-[2rem] shadow-2xl 
                      transition-all duration-300 ease-in-out hover:brightness-110 active:scale-90">
                ${content.buttonText!"mari menjelajah"}
            </a>
        </footer>
    </div>

    <script>
        function updateScale() {
            const canvas = document.getElementById('canvas');
            const windowHeight = window.innerHeight;
            <#-- Skala berdasarkan target tinggi 1920px -->
            const scale = windowHeight / 1920;
            canvas.style.transform = `scale(${"$"}{scale})`;
        }
        window.addEventListener('load', updateScale);
        window.addEventListener('resize', updateScale);
    </script>

</body>
</html>