<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Pencarian Literasi - Graha Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Lato:wght@400&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA: 864x1536px */
        #kios-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; /* Cream Figma #F7F0CB */
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 100px rgba(0,0,0,0.5);
            transform-origin: center center;
        }

        /* TOMBOL X POJOK KANAN ATAS */
        .top-right-close {
            position: absolute; left: 802px; top: 30px;
            font-size: 48px; color: black;
            cursor: pointer; z-index: 1000; font-family: 'Inter', sans-serif;
        }

        /* TOP BAR SEARCH */
        .top-bar { position: absolute; left: 57px; top: 106px; width: 750px; height: 64px; z-index: 100; }
        .search-container { 
            background: white; border-radius: 8px; height: 100%; 
            display: flex; align-items: center; padding: 0 24px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .search-input { 
            width: 100%; border: none; outline: none; font-family: 'Gelasio', serif; 
            font-size: 36px; color: #334155; 
            background: transparent; text-align: center; 
        }

        /* MODAL FILTER: Ukuran Figma 384x224px */
        #filterModal {
            position: absolute; inset: 0;
            background: rgba(0,0,0,0.25); backdrop-filter: blur(4px);
            z-index: 2000; display: none;
            justify-content: center; align-items: center;
        }
        .OverlayFilter {
            width: 384px; height: 224px;
            background-color: #f5f5f4; border-radius: 12px;
            position: relative; transform: scale(1.8); /* Skala proporsional kios */
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            overflow: hidden;
        }

        /* Koordinat Layer Filter Sesuai Snippet Bos Ivan */
        .f-layer { position: absolute; display: inline-flex; align-items: center; cursor: pointer; }
        .check-box { width: 16px; height: 16px; background: rgba(0,0,0,0.2); border-radius: 2px; position: relative; display: flex; justify-content: center; align-items: center; }
        .check-mark { font-size: 10px; color: #3730a3; display: none; }
        input[type="checkbox"]:checked + .check-box .check-mark { display: block; }
        input[type="checkbox"] { display: none; }

        /* AREA KONTEN */
        .content-area { flex: 1; display: flex; flex-direction: column; align-items: center; margin-top: 320px; }
        .no-result-card { 
            width: 764px; height: 703px; background-color: white; border-radius: 16px; 
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            padding: 20px 0; gap: 24px; box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }
    </style>
</head>
<body>

    <div id="kios-canvas">
        <div class="top-right-close" onclick="window.history.back()">x</div>

        <div id="filterModal">
            <div class="OverlayFilter" id="filterBox">
                <div class="absolute left-[89px] top-[23px] w-52 text-center text-black text-2xl font-['Inter']">Filter Kategori</div>
                <div class="absolute left-[354px] top-[9px] cursor-pointer text-2xl font-['Inter']" onclick="toggleFilter()">x</div>
                
                <form id="filterForm" action="/pencarian" method="GET">
                    <input type="hidden" name="query" value="${keyword!""}">
                    
                    <label class="f-layer left-[14px] top-[65px]">
                        <input type="checkbox" name="fJudul" ${(fJudul?? && fJudul)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Judul</div>
                    </label>

                    <label class="f-layer left-[175px] top-[65px]">
                        <input type="checkbox" name="fPenerbit" ${(fPenerbit?? && fPenerbit)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Penerbit</div>
                    </label>

                    <label class="f-layer left-[15px] top-[115px]">
                        <input type="checkbox" name="fIsbn" ${(fIsbn?? && fIsbn)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Isbn</div>
                    </label>

                    <label class="f-layer left-[174px] top-[115px]">
                        <input type="checkbox" name="fPenulis" ${(fPenulis?? && fPenulis)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Penulis</div>
                    </label>
                </form>
            </div>
        </div>

        <div class="top-bar">
            <form id="searchForm" class="search-container" onsubmit="executeSearch(event)">
                <div class="w-12 h-9 bg-zinc-100 rounded flex items-center justify-center cursor-pointer" onclick="document.getElementById('searchForm').requestSubmit()">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#d1d5db" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="searchInput" name="query" placeholder="${keyword!"Sepak bola"}" value="${keyword!""}" class="search-input" autocomplete="off">
                <button type="button" onclick="toggleFilter()" class="ml-auto hover:scale-110 transition-transform">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2L19 12H16L22 20H2L8 12H5L12 2Z" fill="#065f46"/>
                        <rect x="11" y="20" width="2" height="3" fill="#065f46"/>
                    </svg>
                </button>
            </form>
        </div>

        <div class="content-area">
            <div id="searchHeading" class="font-['Gelasio'] font-bold text-slate-700/75 text-[36px] text-center mb-24 w-[800px]">
                Ini hasil pencarian “${keyword!"Sepak bola"}”
            </div>

            <div class="no-result-card">
                <div class="font-['Gelasio'] font-bold text-black text-[36px]">Pencarian Tidak Ditemukan</div>
                <div class="w-80 h-72 flex items-center justify-center">
                    <svg width="280" height="280" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="1.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <div class="font-['Lato'] text-[#9ca3af] text-[36px] text-center px-10">Coba periksa kembali ejaan atau gunakan kata kunci lain.</div>
            </div>
        </div>
    </div>

    <script>
        const modal = document.getElementById('filterModal');
        const searchInput = document.getElementById('searchInput');
        const searchHeading = document.getElementById('searchHeading');

        function toggleFilter() {
            modal.style.display = (modal.style.display === 'flex') ? 'none' : 'flex';
        }

        modal.addEventListener('click', (e) => {
            if (e.target === modal) modal.style.display = 'none';
        });

        function executeSearch(event) {
            event.preventDefault();
            const query = searchInput.value || "${keyword!"Sepak bola"}";
            searchHeading.innerText = `Ini hasil pencarian “` + query + `”`;
            console.log("Mencari data untuk:", query);
        }

        function autoScale() {
            const canvas = document.getElementById('kios-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = `scale($${scale})`;
        }
        window.addEventListener('load', autoScale);
        window.addEventListener('resize', autoScale);
    </script>
</body>
</html>