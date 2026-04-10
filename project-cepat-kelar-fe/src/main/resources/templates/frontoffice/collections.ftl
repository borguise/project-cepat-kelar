<#-- =======================================================
     COLLECTIONS.FTL - FINAL ULTIMATE FRAGMENT (ANTI-JEBOL)
     Fitur: Adaptive Grid, Sticky Search, Filter Aktif, Detail Popup
     ======================================================= -->

<style>
    /* ========================================================
       1. KONTAINER UTAMA FRAGMENT
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
       2. TOP BAR SEARCH (Fixed / Sticky Position)
       ======================================================== */
    .coll-top-bar {
        position: absolute; width: 100%; top: 130px; left: 0;
        padding: 0 5%; z-index: 50; 
        box-sizing: border-box;
    }
    .coll-search-box {
        background: white; border-radius: 25px; height: 90px;
        display: flex; align-items: center; padding: 0 35px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08); border: 2px solid #e5e7eb;
        width: 100%; box-sizing: border-box;
    }
    .coll-search-input {
        width: 100%; border: none; outline: none; font-family: 'Gelasio', serif;
        font-size: 34px; color: #334155; background: transparent;
    }

    /* ========================================================
       3. AREA GULIR (Scroll Area Internal)
       ======================================================== */
    .coll-scroll-area {
        flex: 1; overflow-y: auto !important;
        padding: 0 5%; z-index: 10;
        scrollbar-width: none; display: block;
        box-sizing: border-box;
        -webkit-overflow-scrolling: touch;
    }
    .coll-scroll-area::-webkit-scrollbar { display: none; }
    
    /* Pendorong agar konten putih tidak tertutup Search Bar */
    .coll-vertical-spacer { height: 320px; width: 100%; flex-shrink: 0; }

    /* ========================================================
       4. WADAH PUTIH KOLEKSI (Estetika Kunci)
       ======================================================== */
    .coll-white-wrapper {
        background-color: rgba(255, 255, 255, 0.98); 
        border-radius: 60px; padding: 60px 5%; 
        margin-bottom: 150px; box-shadow: 0 15px 45px rgba(0,0,0,0.03);
        min-height: 900px; display: flex; flex-direction: column;
        box-sizing: border-box; width: 100%;
    }

    /* ========================================================
       5. GRID SYSTEM & KARTU (Anti-Jebol Teks Panjang)
       ======================================================== */
    .coll-grid {
        display: grid; 
        grid-template-columns: repeat(3, minmax(0, 1fr)); /* Proteksi Anti Gepeng */
        gap: 60px 30px; width: 100%;
    }

    .coll-item-card { 
        display: flex; flex-direction: column; align-items: center; 
        cursor: pointer; text-align: center; width: 100%; 
    }
    .coll-img-box {
        width: 100%; aspect-ratio: 2/3; background-color: #f8fafc;
        border-radius: 25px; margin-bottom: 25px; overflow: hidden;
        border: 2px solid #f1f5f9; box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        transition: transform 0.3s ease;
    }
    .coll-item-card:hover .coll-img-box { transform: translateY(-8px); }
    .coll-img-box img { width: 100%; height: 100%; object-fit: cover; }
    
    .coll-title { 
        font-family: 'Gelasio', serif; font-size: 38px; font-weight: bold; 
        color: #3730a3; margin-bottom: 5px;
        width: 100%; display: -webkit-box; -webkit-line-clamp: 2; 
        -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;
    }
    .coll-desc { font-family: 'Lato', sans-serif; font-size: 26px; color: #94a3b8; font-weight: 500; }

    /* ========================================================
       6. MODAL OVERLAY (Double Layer - Filter & Detail)
       ======================================================== */
    /* Umum untuk Overlay */
    .custom-overlay {
        position: absolute; inset: 0; background: rgba(0,0,0,0.5);
        backdrop-filter: blur(10px); z-index: 1000;
        display: none; justify-content: center; align-items: center;
        padding: 20px; box-sizing: border-box;
    }

    /* Modal Detail Buku */
    .detail-card {
        width: 90%; max-width: 700px; max-height: 90%; overflow-y: auto; scrollbar-width: none;
        background: white; border-radius: 50px;
        padding: 60px 5%; position: relative; text-align: center;
        box-shadow: 0 30px 60px rgba(0,0,0,0.2);
    }

    /* Modal Filter Cemara */
    .filter-card {
        width: 90%; max-width: 550px; 
        background: white; border-radius: 40px;
        padding: 50px 5%; position: relative; box-shadow: 0 20px 40px rgba(0,0,0,0.2);
    }

    /* Tombol Filter Interaktif (Anti-Blok Biru) */
    .filter-btn {
        padding: 15px; border: 2px solid #e5e7eb; border-radius: 20px;
        font-size: 24px; font-family: 'Inter', sans-serif; color: #6b7280;
        background-color: white; cursor: pointer; transition: all 0.2s ease;
        outline: none; width: 100%;
    }
    .filter-btn.active {
        border-color: #15803d; color: #15803d;
        background-color: #f0fdf4; font-weight: bold;
    }
</style>

<div class="coll-main-container">
    <div class="coll-batik-layer"></div>

    <#-- ================= TOP BAR (SEARCH) ================= -->
    <div class="coll-top-bar">
        <form action="${searchAction!"/search"}" method="GET" class="coll-search-box" id="mainSearchForm">
            <#-- Input Tersembunyi untuk Filter -->
            <input type="hidden" name="searchBy" id="hiddenSearchCategory" value="judul">
            
            <button type="submit" style="background:none; border:none; cursor:pointer;">
                <i class="fas fa-search text-gray-300 mr-5 text-4xl"></i>
            </button>
            <input type="text" name="keyword" value="${keyword!""}" placeholder="Cari judul, penulis, ..." class="coll-search-input" autocomplete="off">
            <i class="fas fa-tree text-green-700 text-4xl ml-4 cursor-pointer" onclick="openCollFilter()"></i>
        </form>
    </div>

    <#-- ================= AREA KONTEN GULIR ================= -->
    <div class="coll-scroll-area">
        <div class="coll-vertical-spacer"></div>
        <div class="coll-white-wrapper">
            
            <#-- HEADER DINAMIS (Pencarian vs Tampilan Awal) -->
            <#if keyword?? && keyword?trim != "">
                <h2 class="font-['Gelasio'] font-bold text-4xl text-slate-400 text-center mb-12">
                    Hasil pencarian “<span class="text-indigo-600">${keyword}</span>”
                </h2>
            <#else>
                <h2 class="font-['Gelasio'] font-bold text-4xl text-slate-800 text-center mb-12">
                    Koleksi Terbaru
                </h2>
            </#if>

            <#-- LOGIKA DATA (Database Pipeline) -->
            <#assign displayList = bookList![]>
            
            <#if displayList?size == 0>
                <#-- MOCK DATA 6 ITEM UNTUK TAMPILAN AWAL/PREVIEW -->
                <#assign displayList = [
                    {"id": 1, "title": "Senja", "desc": "Deskripsi Singkat"},
                    {"id": 2, "title": "Malam", "desc": "Buku Puisi"},
                    {"id": 3, "title": "Pagi", "desc": "Motivasi"},
                    {"id": 4, "title": "Jurnal Perjalanan Panjang", "desc": "Biografi"},
                    {"id": 5, "title": "Travel ke Ujung Dunia", "desc": "Petualangan"},
                    {"id": 6, "title": "Liburan", "desc": "Buku Anak"}
                ]>
            </#if>

            <#-- RENDER GRID -->
            <div class="coll-grid">
                <#list displayList as b>
                    <div class="coll-item-card" onclick="openBookDetail('${b.title?js_string}')">
                        <div class="coll-img-box">
                            <img src="/admin/collections/image/${b.id}" onerror="this.src='https://placehold.co/400x600/e2e8f0/64748b?text=${b.title}'">
                        </div>
                        <span class="coll-title">${b.title}</span>
                        <span class="coll-desc">${b.desc!"Deskripsi"}</span>
                    </div>
                </#list>
            </div>
        </div>
    </div>

    <#-- ================= POPUP 1: DETAIL BUKU ================= -->
    <div id="bookDetailOverlay" class="custom-overlay" onclick="closeBookDetail()">
        <div class="detail-card" onclick="event.stopPropagation()">
            <div class="absolute right-8 top-6 text-4xl cursor-pointer font-bold text-slate-400 hover:text-slate-600" onclick="closeBookDetail()">X</div>
            <h2 id="detailTitle" class="text-5xl font-bold text-[#3730a3] mb-8 mt-4">Judul</h2>
            <div class="w-full max-w-[300px] aspect-[2/3] mx-auto bg-slate-100 rounded-2xl mb-8 flex items-center justify-center border-2 border-slate-200 overflow-hidden">
                <img id="detailImage" src="" class="w-full h-full object-cover">
            </div>
            <p class="text-2xl text-slate-600 leading-relaxed mb-10 px-2">
                Menampilkan detail data untuk <strong id="detailName" class="text-slate-800">...</strong> yang ditarik secara dinamis dari katalog database Graha Pusat Literasi.
            </p>
            <button class="bg-[#3730a3] text-white text-2xl px-12 py-4 rounded-full font-bold shadow-lg hover:bg-indigo-800 transition" onclick="closeBookDetail()">
                Kembali
            </button>
        </div>
    </div>

    <#-- ================= POPUP 2: FILTER PENCARIAN ================= -->
    <div id="collFilterOverlay" class="custom-overlay" onclick="closeCollFilter()">
        <div class="filter-card" onclick="event.stopPropagation()">
            <div class="absolute right-8 top-6 text-3xl cursor-pointer font-bold text-slate-400 hover:text-slate-600" onclick="closeCollFilter()">X</div>
            <h3 class="text-4xl font-bold text-center mb-8 text-slate-800">Filter Kategori</h3>
            <div class="grid grid-cols-2 gap-4">
                <button type="button" class="filter-btn active" onclick="selectCategory(this, 'judul')">Judul</button>
                <button type="button" class="filter-btn" onclick="selectCategory(this, 'penulis')">Penulis</button>
                <button type="button" class="filter-btn" onclick="selectCategory(this, 'tahun')">Tahun</button>
                <button type="button" class="filter-btn" onclick="selectCategory(this, 'kategori')">Kategori</button>
            </div>
            <button class="w-full mt-10 bg-green-700 text-white py-4 rounded-2xl text-2xl font-bold shadow-lg hover:bg-green-800 transition" onclick="applyFilter()">
                Terapkan Filter
            </button>
        </div>
    </div>
</div>

<#-- ================= SCRIPT LOGIKA ================= -->
<script>
    // 1. FUNGSI DETAIL BUKU
    function openBookDetail(title) {
        // Menggunakan textContent agar aman dari karakter khusus
        document.getElementById('detailTitle').textContent = title;
        document.getElementById('detailName').textContent = title;
        document.getElementById('detailImage').src = "https://placehold.co/400x600/e2e8f0/64748b?text=" + encodeURIComponent(title);
        document.getElementById('bookDetailOverlay').style.display = 'flex';
    }
    function closeBookDetail() {
        document.getElementById('bookDetailOverlay').style.display = 'none';
    }

    // 2. FUNGSI FILTER PENCARIAN
    let currentCategory = "judul"; 

    function openCollFilter() { 
        document.getElementById('collFilterOverlay').style.display = 'flex'; 
    }
    function closeCollFilter() { 
        document.getElementById('collFilterOverlay').style.display = 'none'; 
    }

    function selectCategory(element, categoryValue) {
        // Hapus status aktif dari semua tombol
        document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
        // Tambah status aktif ke tombol yang diklik
        element.classList.add('active');
        // Simpan nilai pilihan
        currentCategory = categoryValue;
    }

    function applyFilter() {
        // Simpan ke form tersembunyi
        document.getElementById('hiddenSearchCategory').value = currentCategory;
        closeCollFilter();
        // Opsional: Langsung submit form setelah filter diterapkan
        // document.getElementById('mainSearchForm').submit(); 
    }
</script>