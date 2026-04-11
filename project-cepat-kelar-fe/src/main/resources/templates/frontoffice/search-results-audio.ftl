<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Review Hasil Pencarian - Graha Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Lato:wght@400;700&family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }
        
        /* KANVAS KIOSK */
        #kios-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; position: relative; overflow: hidden;
            display: flex; flex-direction: column; box-shadow: 0 0 100px rgba(0,0,0,0.5);
            transform-origin: center center;
        }

        /* TOMBOL KELUAR X */
        .close-gateway { position: absolute; top: 30px; right: 45px; font-size: 50px; color: black; cursor: pointer; z-index: 100; font-family: 'Inter', sans-serif; }

        /* SEARCH BAR */
        .top-bar-container { margin: 100px 52px 80px 52px; z-index: 30; }
        .search-form { background: white; border-radius: 12px; height: 90px; display: flex; align-items: center; padding: 0 35px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .search-input { width: 100%; border: none; outline: none; font-family: 'Gelasio', serif; font-size: 34px; color: #334155; text-align: center; background: transparent; }
        .search-submit-btn { background: none; border: none; cursor: pointer; color: #d1d5db; font-size: 40px; margin-right: 20px; }
        .pine-icon { color: #15803d; font-size: 48px; cursor: pointer; transition: transform 0.2s; }

        /* JUDUL DINAMIS */
        .result-header {
            font-family: 'Gelasio', serif; font-size: 44px; font-weight: 700;
            color: #334155; text-align: center; margin-bottom: 80px;
            padding: 0 48px; opacity: 0.75;
        }

        /* KARTU PUTIH (KONTEN TENGAH) */
        .content-card {
            margin: 0 52px 100px 52px; background: #ffffff; border-radius: 32px;
            flex: 1; padding: 80px 50px;
            display: flex; justify-content: center; align-items: center;
            box-shadow: 0 15px 40px rgba(0,0,0,0.06);
        }

        /* --- STATE: HASIL DITEMUKAN --- */
        .result-grid {
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 90px 45px; width: 100%; max-width: 760px;
        }
        .audio-item { display: flex; align-items: center; gap: 30px; cursor: pointer; }
        .vinyl-record {
            width: 115px; height: 115px; background: black; border-radius: 50%;
            display: flex; justify-content: center; align-items: center; flex-shrink: 0;
            border: 4px solid #e2e8f0;
        }
        .vinyl-dot { width: 18px; height: 18px; background: white; border-radius: 50%; }

        .item-text-group { display: flex; flex-direction: column; gap: 8px; }
        .item-title { font-family: 'Inter', sans-serif; font-size: 24px; font-weight: 700; color: black; }
        .item-desc { font-family: 'Inter', sans-serif; font-size: 19px; color: #475569; line-height: 1.4; }

        /* --- STATE: TIDAK DITEMUKAN --- */
        .not-found-container {
            display: flex; flex-direction: column; align-items: center; text-align: center; gap: 60px;
        }
        .not-found-icon { font-size: 280px; color: #64748b; opacity: 0.4; }
        .not-found-title { font-family: 'Gelasio', serif; font-size: 46px; font-weight: 700; color: #000; }
        .not-found-text { font-family: 'Lato', sans-serif; font-size: 34px; color: #64748b; line-height: 1.5; max-width: 620px; }

        /* MODAL FILTER */
        #filterModal { position: fixed; inset: 0; background: rgba(0, 0, 0, 0.45); backdrop-filter: blur(20px); z-index: 9999; display: none; justify-content: center; align-items: center; }
        .filter-card { width: 620px; background: #ffffff; border-radius: 35px; padding: 60px; position: relative; }
        .checkbox-ui { width: 45px; height: 45px; border: 3px solid #cbd5e1; border-radius: 12px; display: flex; justify-content: center; align-items: center; background: #f8fafc; }
        input:checked + .checkbox-ui { background-color: #3730a3; border-color: #3730a3; }
        .checkbox-ui::after { content: "\f00c"; font-family: "Font Awesome 6 Free"; font-weight: 900; color: white; font-size: 20px; display: none; }
        input:checked + .checkbox-ui::after { display: block; }
    </style>
</head>
<body>

    <div id="kios-canvas">
        <div class="close-gateway" onclick="window.history.back()">X</div>

        <div class="top-bar-container">
            <form action="/search" method="GET" class="search-form" onsubmit="return false;">
                <button type="button" class="search-submit-btn">
                    <i class="fas fa-search"></i>
                </button>
                <input type="text" id="searchInput" name="keyword" class="search-input" value="Gunung Lawu" placeholder="Cari rekaman...">
                <i class="fas fa-tree pine-icon ml-5" onclick="toggleFilter()"></i>
            </form>
        </div>

        <h1 id="dynamicHeader" class="result-header">Ini hasil pencarian “Gunung Lawu”</h1>

        <div class="content-card">
            
            <div id="foundState" class="result-grid">
                <div class="audio-item">
                    <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                    <div class="item-text-group"><span class="item-title">Rekaman 1</span><span class="item-desc">Suara indah nan megah Telaga sarangan</span></div>
                </div>
                <div class="audio-item">
                    <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                    <div class="item-text-group"><span class="item-title">puisi</span><span class="item-desc">Gunung lawu</span></div>
                </div>
                <div class="audio-item">
                    <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                    <div class="item-text-group"><span class="item-title">Pidato duta baca</span><span class="item-desc">Event hari kunjung perpustakaan</span></div>
                </div>
                <div class="audio-item">
                    <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                    <div class="item-text-group"><span class="item-title">Musik</span><span class="item-desc">Indonesia Raya</span></div>
                </div>
                <div class="audio-item">
                    <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                    <div class="item-text-group"><span class="item-title">Daftar anggota</span><span class="item-desc">Panduan mendaftar menjadi anggota</span></div>
                </div>
                <div class="audio-item">
                    <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                    <div class="item-text-group"><span class="item-title">Hari Perpustakaan</span><span class="item-desc">Sambutan kepala perpustakaan</span></div>
                </div>
            </div>

            <div id="notFoundState" class="not-found-container" style="display: none;">
                <h2 class="not-found-title">Pencarian Tidak Ditemukan</h2>
                <i class="fas fa-search-minus not-found-icon"></i>
                <p class="not-found-text">Coba periksa kembali ejaan atau gunakan kata kunci lain.</p>
            </div>

        </div>

        <div id="filterModal">
            <div class="filter-card">
                <div class="absolute right-8 top-6 text-4xl cursor-pointer text-gray-400" onclick="toggleFilter()"><i class="fas fa-times"></i></div>
                <h2 class="text-center text-4xl font-bold mb-14 font-['Inter']">Filter Kategori</h2>
                <div class="grid grid-cols-2 gap-12 mb-12">
                    <label class="flex items-center gap-5 cursor-pointer">
                        <input type="checkbox" class="hidden" checked><div class="checkbox-ui"></div>
                        <span class="text-2xl font-semibold">Judul</span>
                    </label>
                    <label class="flex items-center gap-5 cursor-pointer">
                        <input type="checkbox" class="hidden"><div class="checkbox-ui"></div>
                        <span class="text-2xl font-semibold">Label / instansi</span>
                    </label>
                    <label class="flex items-center gap-5 cursor-pointer">
                        <input type="checkbox" class="hidden"><div class="checkbox-ui"></div>
                        <span class="text-2xl font-semibold">Isbn</span>
                    </label>
                    <label class="flex items-center gap-5 cursor-pointer">
                        <input type="checkbox" class="hidden"><div class="checkbox-ui"></div>
                        <span class="text-2xl font-semibold">pengisi suara</span>
                    </label>
                </div>
                <button class="w-full py-7 bg-[#3730a3] text-white rounded-2xl text-2xl font-bold shadow-lg" onclick="toggleFilter()">Terapkan Filter</button>
            </div>
        </div>
    </div>

    <div style="position: fixed; bottom: 20px; left: 20px; z-index: 10000; background: white; padding: 20px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.2);">
        <p style="margin-bottom: 10px; font-weight: bold;">Review Tampilan:</p>
        <button onclick="updateReview(true)" style="background: #3730a3; color: white; padding: 10px 20px; border-radius: 8px; margin-right: 8px; font-weight: 600;">Ada Hasil</button>
        <button onclick="updateReview(false)" style="background: #ef4444; color: white; padding: 10px 20px; border-radius: 8px; font-weight: 600;">Hasil Gagal</button>
    </div>

    <script>
        function updateReview(found) {
            const f = document.getElementById('foundState'); const nf = document.getElementById('notFoundState');
            const h = document.getElementById('dynamicHeader'); const s = document.getElementById('searchInput');
            if(found) {
                f.style.display = 'grid'; nf.style.display = 'none';
                h.innerText = 'Ini hasil pencarian “Gunung Lawu”'; s.value = 'Gunung Lawu';
            } else {
                f.style.display = 'none'; nf.style.display = 'flex';
                h.innerText = 'Ini hasil pencarian “Sepak bola”'; s.value = 'Sepak bola';
            }
        }
        function toggleFilter() { const m = document.getElementById('filterModal'); m.style.display = (m.style.display === 'flex') ? 'none' : 'flex'; }
        function scaleCanvas() { const canvas = document.getElementById('kios-canvas'); const scale = (window.innerHeight - 40) / 1536; canvas.style.transform = "scale(" + scale + ")"; }
        window.addEventListener('load', scaleCanvas); window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>