<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Hasil Pencarian - Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA: Cream Figma #f7f0cb */
        #kios-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 100px rgba(0,0,0,0.5);
            transform-origin: center center;
        }

        /* MODAL OVERLAY FILTER */
        #filterModal {
            position: absolute; inset: 0;
            background: rgba(0,0,0,0.2); backdrop-filter: blur(4px);
            z-index: 2000; display: none;
            justify-content: center; align-items: center;
        }

        /* UKURAN FIGMA: 384x224px */
        .OverlayFilter {
            width: 384px; height: 224px;
            background-color: #f5f5f4; opacity: 0.95; 
            position: relative; border-radius: 12px;
            overflow: hidden; box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            transform: scale(1.8); /* Skala proporsional kios */
        }

        /* Styling Checkbox Sesuai Snippet */
        .f-item { position: absolute; display: inline-flex; align-items: center; cursor: pointer; }
        .check-box { width: 16px; height: 16px; background: rgba(0,0,0,0.2); border-radius: 2px; position: relative; display: flex; justify-content: center; align-items: center; }
        .check-mark { font-size: 10px; color: #3730a3; display: none; }
        input[type="checkbox"]:checked + .check-box .check-mark { display: block; }
        input[type="checkbox"] { display: none; }

        /* SEARCH BAR */
        .top-bar { position: absolute; width: 100%; top: 148px; padding: 0 52px; z-index: 100; }
        .search-container { background: white; border-radius: 12px; height: 64px; display: flex; align-items: center; padding: 0 24px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); }
        .search-input { width: 100%; border: none; outline: none; font-family: 'Gelasio', serif; font-size: 36px; color: #334155; background: transparent; text-align: center; }

        /* AREA GULIR ANTI-POTONG */
        .scroll-area { flex: 1; overflow-y: auto; padding: 0 52px; z-index: 10; scrollbar-width: none; }
        .scroll-area::-webkit-scrollbar { display: none; }
        .spacer-top { height: 410px; flex-shrink: 0; }

        .results-wrapper { background-color: white; border-radius: 40px; padding: 45px 35px; margin-bottom: 100px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); }
        .book-title-indigo { color: #3730a3; font-family: 'Gelasio', serif; font-weight: bold; }
    </style>
</head>
<body>

    <div id="kios-canvas">
        <div class="absolute top-10 right-12 text-5xl font-['Inter'] cursor-pointer z-[101]" onclick="window.history.back()">X</div>

        <div id="filterModal">
            <div class="OverlayFilter" id="filterBox">
                <div class="absolute left-[89px] top-[23px] w-52 text-center text-black text-2xl font-['Inter']">Filter Kategori</div>
                <div class="absolute left-[354px] top-[9px] cursor-pointer text-2xl font-['Inter'] hover:text-red-500" onclick="toggleFilter()">x</div>
                
                <label class="f-item left-[14px] top-[65px]"><input type="checkbox" id="fJudul"><div class="check-box"><span class="check-mark">✓</span></div><div class="ml-2 text-2xl font-['Inter']">Judul</div></label>
                <label class="f-item left-[175px] top-[65px]"><input type="checkbox" id="fPenerbit"><div class="check-box"><span class="check-mark">✓</span></div><div class="ml-2 text-2xl font-['Inter']">Penerbit</div></label>
                <label class="f-item left-[15px] top-[115px]"><input type="checkbox" id="fIsbn"><div class="check-box"><span class="check-mark">✓</span></div><div class="ml-2 text-2xl font-['Inter']">Isbn</div></label>
                <label class="f-item left-[174px] top-[115px]"><input type="checkbox" id="fPenulis"><div class="check-box"><span class="check-mark">✓</span></div><div class="ml-2 text-2xl font-['Inter']">Penulis</div></label>
            </div>
        </div>

        <div class="top-bar">
            <div class="search-container">
                <img src="https://img.icons8.com/ios/50/d4d4d8/search.png" class="w-8 h-8 opacity-40">
                <input type="text" id="mainSearch" value="Gunung Lawu" class="search-input">
                <button onclick="toggleFilter()" class="hover:scale-110 transition-transform">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2L19 12H16L22 20H2L8 12H5L12 2Z" fill="#065f46"/>
                        <rect x="11" y="20" width="2" height="3" fill="#065f46"/>
                    </svg>
                </button>
            </div>
        </div>

        <div id="scrollArea" class="scroll-area">
            <div class="spacer-top"></div>
            <h2 class="font-['Gelasio'] font-bold text-slate-700/75 text-[44px] text-center mb-16 leading-tight">Ini hasil pencarian “Gunung Lawu”</h2>
            <div class="results-wrapper">
                <div class="grid grid-cols-3 gap-8">
                    <div class="flex flex-col items-center">
                        <img src="/images/frontoffice/baris1.png" class="w-full aspect-[2/3] rounded-2xl object-cover mb-6 border border-zinc-100">
                        <p class="book-title-indigo text-xl text-center leading-snug px-1">Para Penyala cahaya dari Lereng Gunung Lawu</p>
                    </div>
                    <div class="flex flex-col items-center">
                        <img src="/images/frontoffice/baris2.png" class="w-full aspect-[2/3] rounded-2xl object-cover mb-6 border border-zinc-100">
                        <p class="book-title-indigo text-xl text-center leading-snug px-1">Antara Lawu dan Wilis</p>
                    </div>
                    <div class="flex flex-col items-center">
                        <img src="/images/frontoffice/baris3.png" class="w-full aspect-[2/3] rounded-2xl object-cover mb-6 border border-zinc-100">
                        <p class="book-title-indigo text-xl text-center leading-snug px-1">Junior Writerpreneur #4: Cerita dari Lereng Lawu</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const modal = document.getElementById('filterModal');
        const filterBox = document.getElementById('filterBox');

        // FUNGSI TOGGLE: Menampilkan/Menyembunyikan Filter
        function toggleFilter() {
            const isVisible = modal.style.display === 'flex';
            modal.style.display = isVisible ? 'none' : 'flex';
        }

        // LOGIKA KLIK DI LUAR: Menutup jika klik area background
        modal.addEventListener('click', (event) => {
            // Jika target klik adalah modal (background), bukan filterBox (kotak isi)
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Script Skala Kios
        function autoScale() {
            const canvas = document.getElementById('kios-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = `scale(${scale})`;
        }

        window.addEventListener('load', autoScale);
        window.addEventListener('resize', autoScale);
    </script>
</body>
</html>