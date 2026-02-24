<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Koleksi Literasi - Graha Pusat Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA: Cream Figma #f7f0cb */
        #koleksi-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 120px rgba(0,0,0,0.6);
            transform-origin: center center;
        }

        .batik-overlay {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"batikspring.png"}'); 
            background-size: 520px;
            opacity: 0.5; mix-blend-mode: multiply;
            pointer-events: none; z-index: 1;
        }

        .close-btn {
            position: absolute; top: 40px; right: 50px;
            font-size: 60px; color: #1F1F1F;
            cursor: pointer; z-index: 1000; font-family: 'Inter', sans-serif;
            transition: opacity 0.4s ease;
        }

        /* TOP BAR: Search Box dengan Pemicu Aktif */
        .top-bar-fixed {
            position: absolute; width: 100%; top: 150px; left: 0;
            padding: 0 52px; z-index: 30;
        }
        .search-box {
            background: white; border-radius: 20px; height: 90px;
            display: flex; align-items: center; padding: 0 35px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
        }
        .search-input {
            width: 100%; border: none; outline: none; font-family: 'Gelasio', serif;
            font-size: 34px; color: #334155; background: transparent; text-align: center;
        }
        .search-btn { background: none; border: none; padding: 0; cursor: pointer; display: flex; align-items: center; }

        /* AREA GULIR */
        .scroll-area {
            flex: 1; overflow-y: auto;
            padding: 0 52px; z-index: 10;
            scrollbar-width: none;
            display: flex; flex-direction: column;
        }
        .scroll-area::-webkit-scrollbar { display: none; }
        .vertical-spacer { height: 320px; flex-shrink: 0; }

        /* WRAPPER PUTIH TUNGGAL ADAPTIF */
        .white-wrapper {
            background-color: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px);
            border-radius: 40px;
            padding: 55px 40px; 
            margin-bottom: 150px;
            box-shadow: 0 15px 45px rgba(0,0,0,0.03);
            min-height: 900px;
            display: flex; flex-direction: column;
        }

        /* LOGIKA CENTERING UNTUK HASIL SEDIKIT */
        .adaptive-container { flex: 1; display: flex; flex-direction: column; }
        .centered-state { justify-content: center; align-items: center; }

        .collection-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 50px 30px; width: 100%;
        }

        /* MODAL FILTER: Ukuran Proporsional */
        #filterModal { 
            position: absolute; inset: 0; background: rgba(0,0,0,0.5); backdrop-filter: blur(8px); 
            z-index: 2000; display: none; justify-content: center; align-items: center; 
        }
        .OverlayFilter { 
            width: 580px; height: 380px; 
            background-color: white; border-radius: 28px; 
            position: relative; padding: 50px; 
        }

        /* KARTU BUKU */
        .book-card { display: flex; flex-direction: column; align-items: center; text-decoration: none; cursor: pointer; }
        .book-cover {
            width: 100%; aspect-ratio: 2/3; background-color: #f1f5f9;
            border-radius: 20px; margin-bottom: 22px; overflow: hidden;
            border: 1px solid #e2e8f0; box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }
        .book-title { font-family: 'Gelasio', serif; font-size: 32px; font-weight: bold; color: #3730a3; text-align: center; line-height: 1.2; }
        
        /* PAGINASI */
        .pagination-footer { margin-top: 50px; padding-top: 30px; border-top: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; }
    </style>
</head>
<body>

    <div id="koleksi-canvas">
        <div class="batik-overlay"></div>
        <div id="dynamicCloseBtn" class="close-btn" onclick="window.history.back()">x</div>

        <div class="top-bar-fixed">
            <form action="${searchAction!"/search"}" method="GET" id="searchForm" class="search-box">
                <button type="submit" class="search-btn">
                    <i class="fas fa-search text-gray-300 mr-5 text-3xl"></i>
                </button>
                
                <input type="text" name="keyword" value="${keyword!""}" placeholder="Cari judul, penulis, ..." class="search-input" autocomplete="off">
                
                <i class="fas fa-tree text-green-800 text-4xl ml-4 cursor-pointer" onclick="toggleFilter()"></i>
            </form>
        </div>

        <div id="scrollArea" class="scroll-area">
            <div class="vertical-spacer"></div>

            <div class="white-wrapper">
                <#-- JUDUL HASIL PENCARIAN -->
                <h2 class="font-['Gelasio'] font-bold text-4xl text-slate-500/70 text-center mb-12">
                    Ini hasil pencarian “${keyword!"Sepak bola"}”
                </h2>

                <#assign resultCount = (bookList??)?then(bookList?size, 0)>

                <div class="adaptive-container ${(resultCount <= 3)?string('centered-state', '')}">
                    
                    <#if resultCount == 0>
                        <#-- TAMPILAN: TIDAK DITEMUKAN -->
                        <div class="flex flex-col items-center text-center gap-10">
                            <h3 class="font-['Gelasio'] font-bold text-black text-[44px]">Pencarian Tidak Ditemukan</h3>
                            <i class="fas fa-search text-zinc-200 text-[180px]"></i>
                            <p class="font-['Lato'] text-[#9ca3af] text-[32px] px-10">Coba periksa kembali ejaan atau gunakan kata kunci lain.</p>
                        </div>

                    <#elseif resultCount == 1>
                        <#-- TAMPILAN: 1 ITEM (BESAR) -->
                        <#list bookList as book>
                        <div class="flex flex-col items-center">
                            <div class="w-[450px] aspect-[2/3] rounded-3xl overflow-hidden mb-8 shadow-2xl border border-zinc-100">
                                <img src="${book.cover!"https://placehold.co/400x600"}" class="w-full h-full object-cover">
                            </div>
                            <span class="book-title text-5xl">${book.title}</span>
                        </div>
                        </#list>

                    <#elseif resultCount <= 3>
                        <#-- TAMPILAN: 2-3 ITEM (TENGAH) -->
                        <div class="grid grid-cols-${resultCount} gap-12 w-full justify-center">
                            <#list bookList as book>
                            <div class="book-card">
                                <div class="book-cover w-[210px]"><img src="${book.cover!"https://placehold.co/400x600"}"></div>
                                <span class="book-title">${book.title}</span>
                            </div>
                            </#list>
                        </div>

                    <#else>
                        <#-- TAMPILAN: MATCH BANYAK (GRID) -->
                        <div class="collection-grid">
                            <#list bookList as book>
                            <div class="book-card" onclick="openFetchDetail('${book.id}', '${book.title}', '${book.cover}')">
                                <div class="book-cover"><img src="${book.cover!"https://placehold.co/400x600"}"></div>
                                <span class="book-title">${book.title}</span>
                            </div>
                            </#list>
                        </div>
                    </#if>
                </div>

                <#-- PAGINASI: HANYA MUNCUL JIKA HASIL BANYAK -->
                <#if resultCount gt 3>
                <div class="pagination-footer">
                    <a href="?keyword=${keyword!""}&page=${currentPage-1}" class="bg-zinc-100 text-zinc-500 px-8 py-4 rounded-xl font-bold text-xl">← Sblmnya</a>
                    <div class="text-zinc-400 font-['Inter'] text-xl font-semibold">Hal <span class="text-[#3730a3]">${currentPage!1}</span> dari ${totalPages!5}</div>
                    <a href="?keyword=${keyword!""}&page=${currentPage+1}" class="bg-[#3730a3] text-white px-8 py-4 rounded-xl font-bold text-xl shadow-lg">Brkutnya →</a>
                </div>
                </#if>
            </div>
        </div>
    </div>

    <div id="filterModal">
        <div class="OverlayFilter">
            <div class="absolute right-[25px] top-[20px] cursor-pointer text-3xl font-bold" onclick="toggleFilter()">X</div>
            <h1 class="font-['Inter'] font-bold text-[42px] text-center mb-10">Filter Kategori</h1>
            <div class="grid grid-cols-2 gap-8">
                <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-2xl font-['Inter']">Judul</span></div>
                <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-2xl font-['Inter']">Penerbit</span></div>
                <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-2xl font-['Inter']">Isbn</span></div>
                <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-2xl font-['Inter']">Penulis</span></div>
            </div>
        </div>
    </div>

    <script>
        const scrollArea = document.getElementById('scrollArea');
        const closeBtn = document.getElementById('dynamicCloseBtn');

        function toggleFilter() {
            const m = document.getElementById('filterModal');
            m.style.display = (m.style.display === 'flex') ? 'none' : 'flex';
        }

        scrollArea.addEventListener('scroll', () => {
            closeBtn.style.opacity = scrollArea.scrollTop > 80 ? '0' : '1';
        });

        function scaleCanvas() {
            const canvas = document.getElementById('koleksi-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>