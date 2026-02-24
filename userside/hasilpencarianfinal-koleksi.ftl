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

        /* KANVAS UTAMA */
        #koleksi-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; position: relative; overflow: hidden;
            display: flex; flex-direction: column; box-shadow: 0 0 120px rgba(0,0,0,0.6);
            transform-origin: center center;
        }

        .batik-overlay {
            position: absolute; inset: 0; background-image: url('${batikPath!"batikspring.png"}'); 
            background-size: 520px; opacity: 0.5; mix-blend-mode: multiply; pointer-events: none; z-index: 1;
        }

        .close-btn {
            position: absolute; top: 40px; right: 50px; font-size: 60px; color: #1F1F1F;
            cursor: pointer; z-index: 1000; font-family: 'Inter', sans-serif; transition: opacity 0.4s ease;
        }

        /* TOP BAR SEARCH */
        .top-bar-fixed { position: absolute; width: 100%; top: 150px; left: 0; padding: 0 52px; z-index: 30; }
        .search-box { background: white; border-radius: 20px; height: 90px; display: flex; align-items: center; padding: 0 35px; box-shadow: 0 8px 25px rgba(0,0,0,0.05); }
        .search-input { width: 100%; border: none; outline: none; font-family: 'Gelasio', serif; font-size: 34px; color: #334155; background: transparent; text-align: center; }
        
        button.lup-btn { background: none; border: none; cursor: pointer; display: flex; align-items: center; }

        /* AREA KARTU PUTIH TUNGGAL */
        .scroll-area { flex: 1; overflow-y: auto; padding: 0 52px; z-index: 10; scrollbar-width: none; display: flex; flex-direction: column; }
        .scroll-area::-webkit-scrollbar { display: none; }
        .vertical-spacer { height: 350px; flex-shrink: 0; }

        .white-wrapper {
            background-color: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);
            border-radius: 40px; padding: 60px 45px; margin-bottom: 100px;
            box-shadow: 0 15px 45px rgba(0,0,0,0.03); min-height: 900px;
            display: flex; flex-direction: column;
        }

        /* LOGIKA CENTERING */
        .centered-content { flex: 1; display: flex; justify-content: center; align-items: center; }
        .collection-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 60px 35px; width: 100%; }

        /* MODAL FILTER */
        #filterModal { 
            position: absolute; inset: 0; background: rgba(0,0,0,0.5); backdrop-filter: blur(8px); 
            z-index: 2000; display: none; justify-content: center; align-items: center; 
        }
        .OverlayFilter { width: 600px; height: 400px; background: white; border-radius: 30px; position: relative; padding: 50px; }

        /* PAGINASI */
        .pagination-bar { margin-top: 50px; padding-top: 40px; border-top: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; }
    </style>
</head>
<body>

    <div id="koleksi-canvas">
        <div class="batik-overlay"></div>
        <div id="dynamicCloseBtn" class="close-btn" onclick="window.history.back()">x</div>

        <div class="top-bar-fixed">
            <form action="${searchAction!"/search"}" method="GET" class="search-box">
                <button type="submit" class="lup-btn">
                    <i class="fas fa-search text-gray-300 mr-5 text-4xl"></i>
                </button>
                <input type="text" name="keyword" value="${keyword!""}" placeholder="Cari judul, penulis, ..." class="search-input" autocomplete="off">
                <i class="fas fa-tree text-green-800 text-5xl ml-4 cursor-pointer" onclick="toggleFilter()"></i>
            </form>
        </div>

        <div id="scrollArea" class="scroll-area">
            <div class="vertical-spacer"></div>
            
            <#assign resultCount = (bookList??)?then(bookList?size, 0)>

            <div class="white-wrapper">
                <#-- JUDUL HASIL PENCARIAN -->
                <h2 class="font-['Gelasio'] font-bold text-4xl text-slate-500/70 text-center mb-12">
                    Ini hasil pencarian “${keyword!"Sepak bola"}”
                </h2>

                <div class="${(resultCount <= 3)?string('centered-content', '')}">
                    
                    <#if resultCount == 0>
                        <#-- TAMPILAN: TIDAK DITEMUKAN -->
                        <div class="text-center py-20">
                            <h3 class="font-['Gelasio'] font-bold text-5xl text-black mb-10">Pencarian Tidak Ditemukan</h3>
                            <i class="fas fa-search text-zinc-200 text-[200px] mb-10"></i>
                            <p class="text-3xl text-zinc-400 px-10">Coba periksa kembali ejaan atau gunakan kata kunci lain.</p>
                        </div>

                    <#elseif resultCount == 1>
                        <#-- TAMPILAN: 1 ITEM (BESAR) -->
                        <#list bookList as book>
                        <div class="flex flex-col items-center">
                            <div class="w-[450px] aspect-[2/3] bg-white rounded-3xl shadow-2xl border overflow-hidden mb-8">
                                <img src="${book.cover!"https://placehold.co/400x600"}" class="w-full h-full object-cover">
                            </div>
                            <span class="font-['Gelasio'] font-bold text-5xl text-[#3730a3] text-center">${book.title}</span>
                        </div>
                        </#list>

                    <#elseif resultCount <= 3>
                        <#-- TAMPILAN: 2-3 ITEM (TENGAH) -->
                        <div class="grid grid-cols-${resultCount} gap-12 w-full">
                            <#list bookList as book>
                            <div class="flex flex-col items-center">
                                <div class="w-[200px] aspect-[2/3] bg-white rounded-2xl shadow-lg border overflow-hidden mb-6">
                                    <img src="${book.cover!"https://placehold.co/400x600"}" class="w-full h-full object-cover">
                                </div>
                                <span class="font-['Gelasio'] font-bold text-2xl text-[#3730a3] text-center">${book.title}</span>
                            </div>
                            </#list>
                        </div>

                    <#else>
                        <#-- TAMPILAN: MATCH BANYAK (GRID) -->
                        <div class="collection-grid">
                            <#list bookList as book>
                            <div class="flex flex-col items-center">
                                <div class="w-full aspect-[2/3] bg-white rounded-2xl shadow-md border overflow-hidden mb-4">
                                    <img src="${book.cover!"https://placehold.co/400x600"}" class="w-full h-full object-cover">
                                </div>
                                <span class="font-['Gelasio'] font-bold text-xl text-[#3730a3] text-center line-clamp-2">${book.title}</span>
                            </div>
                            </#list>
                        </div>
                    </#if>
                </div>

                <#-- PAGINASI: HANYA MUNCUL JIKA > 3 ITEM -->
                <#if resultCount gt 3>
                <div class="pagination-bar">
                    <a href="?keyword=${keyword!""}&page=${currentPage-1}" class="bg-zinc-100 text-zinc-500 px-10 py-5 rounded-2xl font-bold text-2xl">← Sblmnya</a>
                    <span class="text-zinc-400 text-2xl font-semibold">Hal <b class="text-[#3730a3]">${currentPage!1}</b> dari ${totalPages!5}</span>
                    <a href="?keyword=${keyword!""}&page=${currentPage+1}" class="bg-[#3730a3] text-white px-10 py-5 rounded-2xl font-bold text-2xl shadow-lg">Brkutnya →</a>
                </div>
                </#if>
            </div>
        </div>

        <div id="filterModal">
            <div class="OverlayFilter">
                <div class="absolute right-8 top-6 text-4xl cursor-pointer font-bold" onclick="toggleFilter()">x</div>
                <h2 class="text-5xl font-bold text-center mb-10">Filter Kategori</h2>
                <div class="grid grid-cols-2 gap-8">
                    <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-3xl">Judul</span></div>
                    <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-3xl">Penerbit</span></div>
                    <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-3xl">Isbn</span></div>
                    <div class="flex items-center gap-4"><div class="w-8 h-8 bg-zinc-100 rounded border"></div><span class="text-3xl">Penulis</span></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const scrollArea = document.getElementById('scrollArea');
        const closeBtn = document.getElementById('dynamicCloseBtn');

        // Sembunyikan X saat scroll agar tidak menutupi search bar
        scrollArea.addEventListener('scroll', () => {
            closeBtn.style.opacity = scrollArea.scrollTop > 80 ? '0' : '1';
        });

        function toggleFilter() {
            const m = document.getElementById('filterModal');
            m.style.display = (m.style.display === 'flex') ? 'none' : 'flex';
        }

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