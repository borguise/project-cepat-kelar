<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Hasil Pencarian Literasi"}</title>
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

        /* MODAL FILTER: Ukuran Figma 384x224px */
        #filterModal {
            position: absolute; inset: 0;
            background: rgba(0,0,0,0.2); backdrop-filter: blur(4px);
            z-index: 2000; display: none;
            justify-content: center; align-items: center;
        }
        .OverlayFilter {
            width: 384px; height: 224px;
            background-color: #f5f5f4; opacity: 0.95; 
            position: relative; border-radius: 12px;
            overflow: hidden; box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            transform: scale(1.8); /* Skala proporsional kios */
        }

        /* Checkbox & Layer Sesuai Snippet */
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
                <div class="absolute left-[354px] top-[9px] cursor-pointer text-2xl font-['Inter']" onclick="toggleFilter()">x</div>
                
                <form id="filterForm" action="${searchAction!"/koleksi"}" method="GET">
                    <input type="hidden" name="query" value="${keyword!""}">
                    
                    <label class="f-item left-[14px] top-[65px]">
                        <input type="checkbox" name="fJudul" value="true" ${(fJudul?? && fJudul)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Judul</div>
                    </label>

                    <label class="f-item left-[175px] top-[65px]">
                        <input type="checkbox" name="fPenerbit" value="true" ${(fPenerbit?? && fPenerbit)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Penerbit</div>
                    </label>

                    <label class="f-item left-[15px] top-[115px]">
                        <input type="checkbox" name="fIsbn" value="true" ${(fIsbn?? && fIsbn)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Isbn</div>
                    </label>

                    <label class="f-item left-[174px] top-[115px]">
                        <input type="checkbox" name="fPenulis" value="true" ${(fPenulis?? && fPenulis)?string('checked', '')}>
                        <div class="check-box"><span class="check-mark">✓</span></div>
                        <div class="ml-2 text-2xl font-['Inter']">Penulis</div>
                    </label>

                    <#-- Tombol Terapkan Otomatis (Opsional) -->
                    <button type="submit" id="submitFilter" class="hidden"></button>
                </form>
            </div>
        </div>

        <div class="top-bar">
            <div class="search-container">
                <img src="https://img.icons8.com/ios/50/d4d4d8/search.png" class="w-8 h-8 opacity-40">
                <input type="text" value="${keyword!"Gunung Lawu"}" class="search-input">
                <button onclick="toggleFilter()" class="hover:scale-110 transition-transform">
                    <#-- SVG Pine Tree Anti-Pecah -->
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2L19 12H16L22 20H2L8 12H5L12 2Z" fill="#065f46"/>
                        <rect x="11" y="20" width="2" height="3" fill="#065f46"/>
                    </svg>
                </button>
            </div>
        </div>

        <div id="scrollArea" class="scroll-area">
            <div class="spacer-top"></div>
            
            <h2 class="font-['Gelasio'] font-bold text-slate-700/75 text-[44px] text-center mb-16 leading-tight">
                Ini hasil pencarian “${keyword!"Gunung Lawu"}”
            </h2>

            <div class="results-wrapper">
                <div class="grid grid-cols-3 gap-8">
                    
                    <#if bookList?? && bookList?size gt 0>
                        <#list bookList as book>
                            <div class="flex flex-col items-center">
                                <img src="${book.cover!"baris1.png"}" class="w-full aspect-[2/3] rounded-2xl object-cover mb-6 border border-zinc-100">
                                <p class="book-title-indigo text-xl text-center leading-snug px-1">${book.title}</p>
                            </div>
                        </#list>
                    <#else>
                        <#-- Pesan jika data kosong -->
                        <div class="col-span-3 text-center py-20">
                            <p class="font-['Gelasio'] text-slate-400 text-3xl">Buku tidak ditemukan.</p>
                        </div>
                    </#if>

                </div>
            </div>
        </div>
    </div>

    <script>
        const modal = document.getElementById('filterModal');

        function toggleFilter() {
            const isVisible = modal.style.display === 'flex';
            modal.style.display = isVisible ? 'none' : 'flex';
        }

        // KLIK LUAR UNTUK TUTUP:
        modal.addEventListener('click', (e) => {
            if (e.target === modal) modal.style.display = 'none';
        });

        // Submit otomatis saat checkbox berubah (Opsional)
        document.querySelectorAll('#filterForm input').forEach(input => {
            input.addEventListener('change', () => {
                document.getElementById('submitFilter').click();
            });
        });

        // Auto Scaling Layar Kios
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