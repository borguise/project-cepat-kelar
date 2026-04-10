<#-- =======================================================
     COLLECTIONS.FTL - THE ULTIMATE KIOSK FRAGMENT
     Fitur: Grid, Search, Filter, Not Found, & Detail Overlay
     ======================================================= -->

<style>
    /* ========================================================
       1. KONTAINER UTAMA
       ======================================================== */
    .coll-main-container {
        width: 100%; min-height: 100%;
        background-color: #f7f0cb; position: relative;
        display: flex; flex-direction: column; overflow: hidden;
        box-sizing: border-box;
    }

    .coll-batik-layer {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
        background-size: 520px; opacity: 0.4; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    /* ========================================================
       2. TOP BAR SEARCH 
       ======================================================== */
    .coll-top-bar {
        position: absolute; width: 100%; top: 130px; left: 0;
        padding: 0 5%; z-index: 50; box-sizing: border-box;
    }
    .coll-search-box {
        background: white; border-radius: 12px; height: 75px; 
        display: flex; align-items: center; padding: 0 25px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05); width: 100%; box-sizing: border-box;
    }
    .coll-search-input {
        width: 100%; border: none; outline: none; font-family: 'Gelasio', serif;
        font-size: 32px; color: #64748b; background: transparent; text-align: center;
    }

    /* ========================================================
       3. AREA GULIR (Pencarian & Grid)
       ======================================================== */
    .coll-scroll-area {
        flex: 1; overflow-y: auto !important; padding: 0 5%; z-index: 10;
        scrollbar-width: none; display: block; box-sizing: border-box;
        -webkit-overflow-scrolling: touch;
    }
    .coll-scroll-area::-webkit-scrollbar { display: none; }
    .coll-vertical-spacer { height: 260px; width: 100%; flex-shrink: 0; }

    .coll-search-heading {
        font-family: 'Gelasio', serif; font-weight: bold; color: #71717a; 
        font-size: 40px; text-align: center; margin-bottom: 30px;
    }

    .coll-white-wrapper {
        background-color: rgba(255, 255, 255, 0.98); 
        border-radius: 40px; padding: 45px 35px 35px 35px; margin-bottom: 120px; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.02); min-height: 700px; 
        display: flex; flex-direction: column; width: 100%; box-sizing: border-box;
    }

    /* ========================================================
       4. GRID KARTU BUKU
       ======================================================== */
    .coll-adaptive-grid {
        display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 40px 25px; width: 100%;
    }
    .coll-adaptive-grid.single-item { grid-template-columns: 1fr; justify-items: center; }
    .coll-adaptive-grid.few-items { display: flex; justify-content: center; gap: 30px; flex-wrap: wrap; }

    .coll-book-card { display: flex; flex-direction: column; align-items: center; cursor: pointer; }
    .coll-book-cover {
        width: 100%; aspect-ratio: 2/3; background-color: #f1f5f9; border-radius: 20px; 
        margin-bottom: 20px; overflow: hidden; border: 1px solid #e2e8f0; 
        box-shadow: 0 8px 20px rgba(0,0,0,0.06); transition: transform 0.3s ease;
    }
    .single-item .coll-book-cover { width: 350px; }
    .few-items .coll-book-cover { width: 220px; }
    .coll-book-card:hover .coll-book-cover { transform: translateY(-5px); }
    .coll-book-cover img { width: 100%; height: 100%; object-fit: cover; }
    
    .coll-book-title { 
        font-family: 'Gelasio', serif; font-size: 26px; font-weight: bold; color: #3730a3; 
        text-align: center; width: 100%; display: -webkit-box; -webkit-line-clamp: 2; 
        -webkit-box-orient: vertical; overflow: hidden;
    }
    .coll-book-desc { font-family: 'Lato', sans-serif; font-size: 20px; color: #94a3b8; font-weight: 500; margin-top: 5px;}

    /* Paginasi */
    .coll-pagination { margin-top: auto; padding-top: 40px; display: flex; justify-content: space-between; align-items: center; width: 100%; }
    .btn-page-prev, .btn-page-next { font-family: 'Inter', sans-serif; padding: 12px 24px; border-radius: 12px; font-weight: 600; font-size: 20px; text-decoration: none; }
    .btn-page-prev { background-color: #f4f4f5; color: #71717a; }
    .btn-page-next { background-color: #3730a3; color: white; }
    .page-info { font-family: 'Inter', sans-serif; color: #94a3b8; font-size: 20px; font-weight: 500; }
    .page-info strong { color: #3730a3; font-weight: bold; }

    /* Not Found State */
    .coll-no-result { display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 40px 0; gap: 24px; text-align: center; flex: 1; }
    .coll-no-result-title { font-family: 'Gelasio', serif; font-weight: bold; color: black; font-size: 36px; }
    .coll-no-result-desc { font-family: 'Lato', sans-serif; color: #9ca3af; font-size: 36px; padding: 0 40px; }

    /* ========================================================
       5. MODAL DETAIL BUKU FULL PAGE (Desain Custom Ivan)
       ======================================================== */
    .det-full-overlay {
        position: absolute; inset: 0; background-color: #f7f0cb; 
        z-index: 1500; display: none; flex-direction: column; align-items: center;
        overflow-y: auto !important; scrollbar-width: none; box-sizing: border-box;
    }
    .det-full-overlay::-webkit-scrollbar { display: none; }
    
    .det-close-btn {
        position: absolute; top: 30px; right: 45px; font-size: 50px; color: black; 
        cursor: pointer; z-index: 1600; font-family: 'Inter', sans-serif;
    }
    .det-back-link {
        margin-top: 130px; margin-bottom: 25px; color: #38bdf8; /* Biru terang */
        font-family: 'Lato', sans-serif; font-size: 24px; font-weight: 600; cursor: pointer;
    }
    .det-white-card {
        width: 90%; max-width: 764px; background: white; border-radius: 16px;
        padding: 50px; display: flex; flex-direction: column; margin-bottom: 80px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05); box-sizing: border-box;
    }
    
    .det-header-info { display: flex; gap: 40px; margin-bottom: 60px; }
    .det-cover-box { width: 240px; height: 320px; flex-shrink: 0; border-radius: 8px; overflow: hidden; box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
    .det-cover-img { width: 100%; height: 100%; object-fit: cover; }
    .det-meta-data { flex: 1; text-align: center; display: flex; flex-direction: column; justify-content: center; gap: 20px; }
    
    .det-info-box {
        background: white; border-radius: 16px; padding: 25px; margin-bottom: 25px;
        box-shadow: 0px 4px 15px rgba(0,0,0,0.08); text-align: center; border: 1px solid #f1f5f9;
    }
    .det-label-text { font-family: 'Gelasio', serif; font-weight: bold; font-size: 32px; color: black; margin-bottom: 8px; }
    .det-value-text { font-family: 'Gelasio', serif; font-weight: bold; font-size: 32px; color: black; }

    /* ========================================================
       6. MODAL FILTER CEMARA 
       ======================================================== */
    .filter-overlay {
        position: absolute; inset: 0; background: rgba(0,0,0,0.3); backdrop-filter: blur(4px); 
        z-index: 2000; display: none; justify-content: center; align-items: center;
    }
    .filter-card { width: 450px; background: #f5f5f4; border-radius: 20px; padding: 40px; position: relative; box-shadow: 0 20px 40px rgba(0,0,0,0.15); }
    .filter-btn { padding: 12px; border: 2px solid #e5e7eb; border-radius: 12px; font-size: 20px; font-family: 'Inter', sans-serif; color: #6b7280; background-color: white; cursor: pointer; transition: all 0.2s ease; width: 100%; }
    .filter-btn.active { border-color: #15803d; color: #15803d; background-color: #f0fdf4; font-weight: bold; }
</style>

<div class="coll-main-container">
    <div class="coll-batik-layer"></div>

    <#-- ================= TOP BAR (SEARCH) ================= -->
    <div class="coll-top-bar">
        <form action="${searchAction!"/search"}" method="GET" class="coll-search-box" id="mainSearchForm">
            <input type="hidden" name="searchBy" id="hiddenSearchCategory" value="judul">
            <button type="submit" style="background:none; border:none; cursor:pointer;">
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#d1d5db" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </button>
            <input type="text" name="keyword" value="${keyword!""}" placeholder="Cari judul, penulis, ..." class="coll-search-input" autocomplete="off">
            <button type="button" onclick="openCollFilter()" class="ml-auto hover:scale-110 transition-transform cursor-pointer" style="background:none; border:none; padding:0;">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 2L19 12H16L22 20H2L8 12H5L12 2Z" fill="#065f46"/><rect x="11" y="20" width="2" height="3" fill="#065f46"/></svg>
            </button>
        </form>
    </div>

    <#-- ================= AREA KONTEN GULIR ================= -->
    <div class="coll-scroll-area">
        <div class="coll-vertical-spacer"></div>
        
        <#assign isSearching = keyword?? && keyword?trim != "">

        <#if isSearching>
            <div class="coll-search-heading">Ini hasil pencarian “${keyword}”</div>
        <#else>
            <div class="coll-search-heading">Koleksi Tersedia</div>
        </#if>

        <div class="coll-white-wrapper">
            <#assign displayList = bookList![]>
            <#assign resultCount = displayList?size>

            <#-- Skenario: Tidak Ditemukan -->
            <#if isSearching && resultCount == 0>
                <div class="coll-no-result">
                    <div class="coll-no-result-title">Pencarian Tidak Ditemukan</div>
                    <div class="w-[240px] h-[240px] flex items-center justify-center">
                        <svg width="100%" height="100%" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="1.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <div class="coll-no-result-desc">Coba periksa kembali ejaan atau gunakan kata kunci lain.</div>
                </div>

            <#-- Skenario: Ditemukan / Tampilan Awal -->
            <#else>
                <#-- Mock Data jika belum ada koneksi DB agar halaman awal tidak kosong melompong -->
                <#if !isSearching && resultCount == 0>
                    <#assign displayList = [
                        {"id": 1, "title": "Senja", "callNum": "899.221", "cat": "Antologi", "author": "Penulis A", "pub": "Penerbit X", "phys": "100 hal."},
                        {"id": 2, "title": "Malam", "callNum": "899.222", "cat": "Puisi", "author": "Penulis B", "pub": "Penerbit Y", "phys": "150 hal."},
                        {"id": 3, "title": "Pagi", "callNum": "899.223", "cat": "Novel", "author": "Penulis C", "pub": "Penerbit Z", "phys": "200 hal."},
                        {"id": 4, "title": "Jurnal", "callNum": "899.224", "cat": "Biografi", "author": "Penulis D", "pub": "Penerbit W", "phys": "250 hal."},
                        {"id": 5, "title": "Travel", "callNum": "899.225", "cat": "Panduan", "author": "Penulis E", "pub": "Penerbit V", "phys": "300 hal."},
                        {"id": 6, "title": "Liburan", "callNum": "899.226", "cat": "Anak", "author": "Penulis F", "pub": "Penerbit U", "phys": "50 hal."}
                    ]>
                    <#assign resultCount = 6>
                </#if>

                <#assign gridClass = "coll-adaptive-grid">
                <#if resultCount == 1> <#assign gridClass = "coll-adaptive-grid single-item">
                <#elseif resultCount <= 3> <#assign gridClass = "coll-adaptive-grid few-items">
                </#if>

                <div class="${gridClass}">
                    <#list displayList as b>
                        <div class="coll-book-card" onclick="openFullDetail('${b.id}', '${b.title?js_string}', '${(b.callNum!"-")?js_string}', '${(b.cat!"-")?js_string}', '${(b.author!"-")?js_string}', '${(b.pub!"-")?js_string}', '${(b.phys!"-")?js_string}')">
                            <div class="coll-book-cover">
                                <img id="thumb-${b.id}" src="/admin/collections/image/${b.id}" onerror="this.src='https://placehold.co/400x600/f8fafc/94a3b8?text=Cover'">
                            </div>
                            <span class="coll-book-title">${b.title}</span>
                            <span class="coll-book-desc">${b.cat!"Koleksi"}</span>
                        </div>
                    </#list>
                </div>

                <#if (totalPages!1) gt 1>
                    <div class="coll-pagination">
                        <a href="?keyword=${keyword!""}&page=${(currentPage!1)-1}" class="btn-page-prev">← Sblmnya</a>
                        <div class="page-info">Hal <strong>${currentPage!1}</strong> dari ${totalPages!1}</div>
                        <a href="?keyword=${keyword!""}&page=${(currentPage!1)+1}" class="btn-page-next">Brkutnya →</a>
                    </div>
                </#if>
            </#if>
        </div>
    </div>

    <#-- ================= POPUP 1: FULL PAGE DETAIL (Desain Custom) ================= -->
    <div id="fullDetailOverlay" class="det-full-overlay">
        <div class="coll-batik-layer"></div>
        
        <div class="det-close-btn" onclick="closeFullDetail()">X</div>
        
        <div class="det-back-link" onclick="closeFullDetail()">&lt; Kembali ke daftar koleksi</div>

        <div class="det-white-card">
            <div class="det-header-info">
                <div class="det-cover-box">
                    <img id="detCover" class="det-cover-img" src="" alt="Cover">
                </div>
                <div class="det-meta-data">
                    <h1 id="detTitle" class="font-['Gelasio'] font-bold text-3xl leading-tight">Judul Buku</h1>
                    <div id="detCallNum" class="font-['Gelasio'] font-bold text-5xl mt-2 text-black">899.221</div>
                    <div id="detCat" class="font-['Gelasio'] font-bold text-4xl text-black">Novel</div>
                </div>
            </div>

            <div class="mt-4">
                <h2 class="font-['Gelasio'] font-bold text-4xl mb-10 ml-4">Keterangan</h2>
                
                <div class="det-info-box">
                    <div class="det-label-text">Tajuk Pengarang</div>
                    <div id="detAuthor" class="det-value-text">Nama Pengarang</div>
                </div>

                <div class="det-info-box">
                    <div class="det-label-text">Data Penerbit</div>
                    <div id="detPublisher" class="det-value-text">Data Penerbit</div>
                </div>

                <div class="det-info-box">
                    <div class="det-label-text">Data Fisik</div>
                    <div id="detPhysical" class="det-value-text">Data Fisik</div>
                </div>
            </div>
        </div>
    </div>

    <#-- ================= POPUP 2: FILTER CEMARA ================= -->
    <div id="collFilterOverlay" class="filter-overlay" onclick="closeCollFilter()">
        <div class="filter-card" onclick="event.stopPropagation()">
            <div class="absolute right-6 top-5 text-2xl cursor-pointer font-bold text-slate-400 hover:text-slate-600" onclick="closeCollFilter()">X</div>
            <h3 class="text-3xl font-bold text-center mb-6 text-slate-800 font-['Inter']">Filter Kategori</h3>
            
            <div class="grid grid-cols-2 gap-4">
                <button type="button" class="filter-btn active" onclick="selectCategory(this, 'judul')">Judul</button>
                <button type="button" class="filter-btn" onclick="selectCategory(this, 'penulis')">Penulis</button>
                <button type="button" class="filter-btn" onclick="selectCategory(this, 'tahun')">Tahun</button>
                <button type="button" class="filter-btn" onclick="selectCategory(this, 'kategori')">Kategori</button>
            </div>
            
            <button class="w-full mt-8 bg-[#15803d] text-white py-3 rounded-2xl text-xl font-bold shadow-md" onclick="applyFilter()">
                Terapkan
            </button>
        </div>
    </div>
</div>

<script>
    // --- 1. FUNGSI DETAIL BUKU (FULL PAGE) ---
    function openFullDetail(id, title, callNum, category, author, publisher, physical) {
        document.getElementById('detTitle').textContent = title;
        document.getElementById('detCallNum').textContent = callNum;
        document.getElementById('detCat').textContent = category;
        document.getElementById('detAuthor').textContent = author;
        document.getElementById('detPublisher').textContent = publisher;
        document.getElementById('detPhysical').textContent = physical;
        
        const thumbImg = document.getElementById('thumb-' + id);
        const modalImg = document.getElementById('detCover');
        modalImg.src = thumbImg ? thumbImg.src : "https://placehold.co/400x600/f8fafc/94a3b8?text=Cover";
        
        document.getElementById('fullDetailOverlay').style.display = 'flex';
    }
    
    function closeFullDetail() { 
        document.getElementById('fullDetailOverlay').style.display = 'none'; 
    }

    // --- 2. FUNGSI FILTER CEMARA ---
    let currentCategory = "judul"; 

    function openCollFilter() { document.getElementById('collFilterOverlay').style.display = 'flex'; }
    function closeCollFilter() { document.getElementById('collFilterOverlay').style.display = 'none'; }

    function selectCategory(element, categoryValue) {
        document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
        element.classList.add('active');
        currentCategory = categoryValue;
    }

    function applyFilter() {
        document.getElementById('hiddenSearchCategory').value = currentCategory;
        closeCollFilter();
    }
</script>