<#-- 
  Variabel yang diharapkan dari Backend Java:
  - keyword: String kata kunci
  - tracks: List objek hasil (id, title, description)
  - fJudul, fPenerbit, fIsbn, fPenulis: Boolean status filter
-->

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${keyword!"Hasil Pencarian"} - Graha Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Lato:wght@400;700&family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }
        #kios-canvas { width: 864px; height: 1536px; background-color: #f7f0cb; position: relative; overflow: hidden; display: flex; flex-direction: column; box-shadow: 0 0 100px rgba(0,0,0,0.5); transform-origin: center center; }
        .close-gateway { position: absolute; top: 30px; right: 45px; font-size: 50px; color: black; cursor: pointer; z-index: 100; font-family: 'Inter', sans-serif; }

        /* SEARCHBAR FUNCTIONAL */
        .top-bar-container { margin: 100px 52px 80px 52px; z-index: 30; }
        .search-form { background: white; border-radius: 12px; height: 90px; display: flex; align-items: center; padding: 0 35px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .search-input { width: 100%; border: none; outline: none; font-family: 'Gelasio', serif; font-size: 34px; color: #334155; text-align: center; background: transparent; }
        .search-submit-btn { background: none; border: none; cursor: pointer; color: #d1d5db; font-size: 40px; margin-right: 20px; }
        .pine-icon { color: #15803d; font-size: 48px; cursor: pointer; }

        /* CONTENT LAYOUT */
        .result-header { font-family: 'Gelasio', serif; font-size: 44px; font-weight: 700; color: #334155; text-align: center; margin-bottom: 80px; padding: 0 48px; opacity: 0.75; }
        .content-card { margin: 0 52px 100px 52px; background: #ffffff; border-radius: 32px; flex: 1; padding: 80px 50px; display: flex; justify-content: center; align-items: center; box-shadow: 0 15px 40px rgba(0,0,0,0.06); }

        /* GRID RESULTS */
        .result-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 90px 45px; width: 100%; max-width: 760px; }
        .audio-item { display: flex; align-items: center; gap: 30px; cursor: pointer; }
        .vinyl-record { width: 115px; height: 115px; background: black; border-radius: 50%; display: flex; justify-content: center; align-items: center; flex-shrink: 0; border: 4px solid #e2e8f0; }
        .vinyl-dot { width: 18px; height: 18px; background: white; border-radius: 50%; }

        /* NOT FOUND STATE */
        .not-found-container { display: flex; flex-direction: column; align-items: center; text-align: center; gap: 60px; }
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

        <#-- Form Utama: Diarahkan ke /search-results-audio -->
        <div class="top-bar-container">
            <form action="/search-results-audio" method="GET" class="search-form">
                <button type="submit" class="search-submit-btn">
                    <i class="fas fa-search"></i>
                </button>
                <input type="text" name="keyword" class="search-input" value="${keyword!""}" placeholder="Cari rekaman...">
                <i class="fas fa-tree pine-icon ml-5" onclick="toggleFilter()"></i>
            </form>
        </div>

        <h1 class="result-header">Ini hasil pencarian “${keyword!"Pencarian"}”</h1>

        <div class="content-card">
            <#-- Logika Kondisional FTL -->
            <#if tracks?? && (tracks?size > 0)>
                <#-- Tampilan Ditemukan -->
                <div class="result-grid">
                    <#list tracks as t>
                    <div class="audio-item" onclick="location.href='/audio/player?id=${t.id}'">
                        <div class="vinyl-record"><div class="vinyl-dot"></div></div>
                        <div class="flex flex-col gap-2">
                            <span class="font-bold text-2xl">${t.title}</span>
                            <span class="text-xl text-slate-600">${t.description!""}</span>
                        </div>
                    </div>
                    </#list>
                </div>
            <#else>
                <#-- Tampilan Tidak Ditemukan -->
                <div class="not-found-container">
                    <h2 class="not-found-title">Pencarian Tidak Ditemukan</h2>
                    <i class="fas fa-search-minus not-found-icon"></i>
                    <p class="not-found-text">Coba periksa kembali ejaan atau gunakan kata kunci lain.</p>
                </div>
            </#if>
        </div>

        <#-- Modal Filter Terarah -->
        <div id="filterModal">
            <div class="filter-card">
                <div class="absolute right-8 top-6 text-4xl cursor-pointer text-gray-400" onclick="toggleFilter()"><i class="fas fa-times"></i></div>
                <h2 class="text-center text-4xl font-bold mb-14 font-['Inter']">Filter Kategori</h2>
                <form action="/search-results-audio" method="GET">
                    <input type="hidden" name="keyword" value="${keyword!""}">
                    <div class="grid grid-cols-2 gap-12 mb-12">
                        <label class="flex items-center gap-5 cursor-pointer">
                            <input type="checkbox" name="fJudul" value="true" class="hidden" ${(fJudul?? && fJudul)?string('checked', '')}>
                            <div class="checkbox-ui"></div><span class="text-2xl font-semibold">Judul</span>
                        </label>
                        <label class="flex items-center gap-5 cursor-pointer">
                            <input type="checkbox" name="fPenerbit" value="true" class="hidden" ${(fPenerbit?? && fPenerbit)?string('checked', '')}>
                            <div class="checkbox-ui"></div><span class="text-2xl font-semibold">Label / instansi</span>
                        </label>
                        <label class="flex items-center gap-5 cursor-pointer">
                            <input type="checkbox" name="fIsbn" value="true" class="hidden" ${(fIsbn?? && fIsbn)?string('checked', '')}>
                            <div class="checkbox-ui"></div><span class="text-2xl font-semibold">Isbn</span>
                        </label>
                        <label class="flex items-center gap-5 cursor-pointer">
                            <input type="checkbox" name="fPenulis" value="true" class="hidden" ${(fPenulis?? && fPenulis)?string('checked', '')}>
                            <div class="checkbox-ui"></div><span class="text-2xl font-semibold">pengisi suara</span>
                        </label>
                    </div>
                    <button type="submit" class="w-full py-7 bg-[#3730a3] text-white rounded-2xl text-2xl font-bold">Terapkan Filter</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleFilter() { const m = document.getElementById('filterModal'); m.style.display = (m.style.display === 'flex') ? 'none' : 'flex'; }
        function scaleCanvas() { const canvas = document.getElementById('kios-canvas'); const scale = (window.innerHeight - 40) / 1536; canvas.style.transform = "scale(" + scale + ")"; }
        window.addEventListener('load', scaleCanvas); window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>