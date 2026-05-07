<#-- =======================================================
     COLLECTIONS.FTL - PROPORTIONAL 3-COLUMN SPA
     Fitur: Smart Centering (1 & 2 Items), 3-Column Grid
     ======================================================= -->

<style>
    /* Menyembunyikan Scrollbar tapi tetap bisa digulir */
    .coll-scroll-area::-webkit-scrollbar { display: none; }
    .coll-scroll-area { scrollbar-width: none; overflow-y: auto; height: 100%; width: 100%; padding-bottom: 100px; position: relative; z-index: 10;}
    
    /* Latar Belakang Batik */
    .coll-batik-layer {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
        background-size: 520px; opacity: 0.12; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    /* MODAL FILTER UI */
    .coll-filter-overlay { 
        position: fixed; inset: 0; background: rgba(0,0,0,0.5); 
        backdrop-filter: blur(8px); z-index: 9999; 
        display: none; justify-content: center; align-items: center; 
    }
    .coll-filter-card {
        width: 600px; background: #ffffff; border-radius: 32px; padding: 50px; position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3); border: 1px solid rgba(255, 255, 255, 0.4);
    }
    .coll-filter-close { position: absolute; top: 35px; right: 40px; font-size: 40px; color: #94a3b8; cursor: pointer; }
    .coll-filter-title { font-family: 'Inter', sans-serif; font-size: 42px; font-weight: 700; color: #1e293b; text-align: center; margin-bottom: 55px; }
    .coll-filter-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 45px 25px; margin-bottom: 60px; }
    .coll-filter-item { display: flex; align-items: center; gap: 20px; cursor: pointer; }
    .coll-checkbox-ui { width: 45px; height: 45px; border: 3px solid #cbd5e1; border-radius: 14px; display: flex; justify-content: center; align-items: center; background: #f8fafc; transition: all 0.2s ease; flex-shrink: 0; }
    .coll-filter-item input { display: none; }
    .coll-filter-item input:checked + .coll-checkbox-ui { background-color: #3730a3; border-color: #3730a3; }
    .coll-checkbox-ui::after { content: "\f00c"; font-family: "Font Awesome 6 Free"; font-weight: 900; color: white; font-size: 22px; display: none; }
    .coll-filter-item input:checked + .coll-checkbox-ui::after { display: block; }
    .coll-label-text { font-family: 'Inter', sans-serif; font-size: 26px; color: #334155; font-weight: 500; }
    .coll-btn-apply { width: 100%; padding: 25px; background-color: #3730a3; color: white; border: none; border-radius: 20px; font-family: 'Inter', sans-serif; font-size: 30px; font-weight: 700; cursor: pointer; }
</style>

<div class="w-full h-full bg-[#f7f0cb] relative overflow-hidden font-['Inter']">
    
    <div class="coll-batik-layer"></div>

    <div class="coll-scroll-area flex flex-col items-center">
        
        <#-- ================= BROWSE VIEW ================= -->
        <div id="viewBrowse" class="w-full max-w-[800px] flex flex-col items-center">
            
            <#-- Search Bar Sinkron -->
            <div class="w-full mb-[50px] mt-[150px] relative">
                <form class="w-full h-[100px] bg-white rounded-[30px] flex items-center px-[40px] shadow-[0_10px_30px_rgba(0,0,0,0.08)]" onsubmit="handleSearch(event)">
                    <button type="submit" class="bg-transparent border-none cursor-pointer">
                        <i class="fas fa-search text-[40px] text-slate-300 mr-6"></i>
                    </button>
                    <input type="text" id="searchInput" class="flex-1 bg-transparent border-none outline-none text-center font-['Gelasio'] font-bold text-[34px] text-[#3730a3]" value="Cari Judul, Pengarang, Penerbit" autocomplete="off" onfocus="if(this.value=='Cari Judul, Pengarang, Penerbit')this.value=''">
                    <i class="fas fa-sliders-h text-[45px] text-[#3730a3] ml-6 cursor-pointer hover:scale-110 transition-transform" onclick="toggleCollFilter()"></i>
                </form>
            </div>

            <#-- Header Status -->
            <#-- Header Pencarian (Dilengkapi Tombol Reset Estetik) -->
            <div id="searchHeader" class="hidden w-full flex-col justify-center items-center mb-[40px] gap-3">
                <div id="searchTitle" class="font-['Gelasio'] font-bold text-[36px] text-slate-700 text-center w-full truncate">
                    Hasil pencarian
                </div>
                <div class="font-['Lato'] text-[20px] font-bold text-sky-500 cursor-pointer flex items-center gap-2 hover:text-sky-600 active:scale-95 transition bg-sky-50 px-4 py-2 rounded-full border border-sky-100" onclick="resetToHome()">
                    <i class="fas fa-times-circle"></i> Bersihkan pencarian
                </div>
            </div>

            <#-- White Card (Wadah Grid) -->
            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-sm min-h-[600px]">
                
                <#-- Grid Kontainer yang dinamis -->
                <div id="gridContainer" class="grid grid-cols-3 gap-[50px_30px]"></div>
                
                <#-- Wadah Not Found -->
                <div id="emptyContainer" class="hidden flex-col items-center justify-center min-h-[500px] text-center gap-[40px]">
                    <div class="font-['Gelasio'] font-bold text-[46px] text-slate-800">Tidak Ditemukan</div>
                    <div class="w-[220px] h-[220px] rounded-full bg-slate-100 flex items-center justify-center text-slate-300 text-[110px] shadow-inner">
                        <i class="fas fa-search-minus"></i>
                    </div>
                    <p class="font-['Lato'] text-[28px] text-slate-500 px-10">Coba gunakan kata kunci lain.</p>
                </div>
            </div>
        </div>

        <#-- ================= DETAIL VIEW ================= -->
        <div id="viewDetail" class="hidden w-full max-w-[800px] flex-col items-center mt-[150px]">
            
            <#-- Tombol Kembali di TENGAH -->
            <div class="w-full flex justify-center mb-[25px] relative z-20">
                <div class="font-['Lato'] text-[26px] font-bold text-sky-500 cursor-pointer flex items-center gap-3 hover:text-sky-600 active:scale-95 transition" onclick="goBack()">
                    <i class="fas fa-chevron-left"></i> Kembali ke daftar koleksi
                </div>
            </div>

            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-xl flex flex-col gap-[50px] mb-[80px]">
                <div class="flex items-start gap-[50px]">
                    <div class="w-[280px] h-[400px] shrink-0 rounded-[16px] overflow-hidden border-[4px] border-slate-100 shadow-lg bg-slate-100">
                        <img id="dtlCover" src="" class="w-full h-full object-cover">
                    </div>
                    <div class="flex-1 flex flex-col justify-center text-center mt-6">
                        <h1 id="dtlTitle" class="font-['Gelasio'] font-bold text-[42px] leading-tight text-slate-900 mb-4">Judul</h1>
                        <div id="dtlCall" class="font-['Gelasio'] font-bold text-[60px] text-[#3730a3]">000.000</div>
                        <div id="dtlCat" class="font-['Gelasio'] font-bold text-[30px] text-slate-400 uppercase mt-2">Kategori</div>
                    </div>
                </div>
                <div class="w-full">
                    <h2 class="font-['Gelasio'] font-bold text-[38px] text-slate-900 mb-[30px] border-b-4 border-slate-100 pb-4 inline-block">Keterangan</h2>
                    <div class="flex flex-col gap-[20px]">
                        <div class="bg-slate-50 rounded-[24px] p-[30px] border-2 border-slate-100 flex flex-col gap-2">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase">Tajuk Pengarang</div>
                            <div id="dtlAuthor" class="font-['Gelasio'] font-bold text-[34px] text-slate-800">-</div>
                        </div>
                        <div class="bg-slate-50 rounded-[24px] p-[30px] border-2 border-slate-100 flex flex-col gap-2">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase">Data Penerbit</div>
                            <div id="dtlPub" class="font-['Gelasio'] font-bold text-[34px] text-slate-800">-</div>
                        </div>
                        <div class="bg-slate-50 rounded-[24px] p-[30px] border-2 border-slate-100 flex flex-col gap-2">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase">Data Fisik</div>
                            <div id="dtlPhysical" class="font-['Gelasio'] font-bold text-[34px] text-slate-800">-</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#-- MODAL FILTER -->
    <div id="collFilterOverlay" class="coll-filter-overlay" onclick="toggleCollFilter()">
        <div class="coll-filter-card" onclick="event.stopPropagation()">
            <div class="coll-filter-close" onclick="toggleCollFilter()"><i class="fas fa-times"></i></div>
            <h2 class="coll-filter-title">Filter Kategori</h2>
            <form onsubmit="applyFilterSearch(event)">
                <div class="coll-filter-grid">
                    <label class="coll-filter-item"><input type="checkbox" id="chkJudul" checked><div class="coll-checkbox-ui"></div><span class="coll-label-text">Judul</span></label>
                    <label class="coll-filter-item"><input type="checkbox" id="chkPengarang"><div class="coll-checkbox-ui"></div><span class="coll-label-text">Pengarang</span></label>
                    <label class="coll-filter-item"><input type="checkbox" id="chkPenerbit"><div class="coll-checkbox-ui"></div><span class="coll-label-text">Penerbit</span></label>
                    <label class="coll-filter-item"><input type="checkbox" id="chkIsbn"><div class="coll-checkbox-ui"></div><span class="coll-label-text">ISBN/Kategori</span></label>
                </div>
                <button type="submit" class="coll-btn-apply">Terapkan Filter</button>
            </form>
        </div>
    </div>

</div>

<script>
    const basePath = "${basePath!"/images/frontoffice"}";
    const dbBooks = [
        <#if bookList?? && bookList?has_content>
            <#list bookList as b>
            { id: ${b.id}, title: "${(b.title!'Tanpa Judul')?js_string}", callNum: "${(b.callNum!'000.000')?js_string}", category: "${(b.cat!'Koleksi')?js_string}", author: "${(b.author!'Anonim')?js_string}", publisher: "${(b.pub!'-')?js_string}", physical: "${(b.phys!'-')?js_string}", img: "/admin/collections/image/${b.id}" }<#if b?has_next>,</#if>
            </#list>
        <#else>
            { id: 1, title: "Seni Memahami Literasi Magetan", callNum: "899.221", category: "Buku Umum", author: "Pemerintah Kab. Magetan", publisher: "Graha Literasi, 2024", physical: "xiv, 250 hlm ; 24 cm", img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+1" },
            { id: 2, title: "Sejarah Gunung Lawu", callNum: "959.8", category: "Sejarah", author: "Dinas Kebudayaan", publisher: "Pustaka Jawa, 2021", physical: "200 hlm ; 21 cm", img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+2" },
            { id: 3, title: "Kumpulan Puisi Pring Sedapur", callNum: "811.1", category: "Sastra", author: "Seniman Lokal", publisher: "Indie Press, 2023", physical: "120 hlm ; 19 cm", img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+3" },
            { id: 4, title: "Ensiklopedia Magetan", callNum: "030.1", category: "Referensi", author: "Tim Riset", publisher: "Pemkab, 2022", physical: "500 hlm ; 30 cm", img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+4" },
            { id: 5, title: "Pesona Wisata Telaga Sarangan", callNum: "910.2", category: "Travel", author: "Pariwisata", publisher: "Graha, 2024", physical: "80 hlm", img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+5" },
            { id: 6, title: "Batik Pring Sedapur", callNum: "746.6", category: "Seni Budaya", author: "Kreator Magetan", publisher: "Pemkab, 2023", physical: "150 hlm", img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+6" }
        </#if>
    ];

<#noparse>
    let currentBooks = [...dbBooks];

    function navigateTo(view) {
        document.getElementById('viewBrowse').classList.toggle('hidden', view !== 'home' && view !== 'search');
        document.getElementById('viewDetail').classList.toggle('hidden', view !== 'detail');
        if(view !== 'detail') {
            document.getElementById('searchHeader').classList.toggle('hidden', view === 'home');
            renderGrid();
        }
    }

    function handleSearch(e) {
        if(e) e.preventDefault();
        const q = document.getElementById('searchInput').value.trim().toLowerCase();
        if(q === '' || q === 'cari judul, pengarang, penerbit') { currentBooks = [...dbBooks]; navigateTo('home'); return; }
        
        const fJudul = document.getElementById('chkJudul').checked;
        const fPengarang = document.getElementById('chkPengarang').checked;
        const fPenerbit = document.getElementById('chkPenerbit').checked;
        const fIsbn = document.getElementById('chkIsbn').checked;

        currentBooks = dbBooks.filter(b => {
            if(!fJudul && !fPengarang && !fPenerbit && !fIsbn) return false;
            let match = false;
            if (fJudul && b.title.toLowerCase().includes(q)) match = true;
            if (fPengarang && b.author.toLowerCase().includes(q)) match = true;
            if (fPenerbit && b.publisher.toLowerCase().includes(q)) match = true;
            if (fIsbn && (b.callNum.toLowerCase().includes(q) || b.category.toLowerCase().includes(q))) match = true;
            return match;
        });
        document.getElementById('searchTitle').innerText = 'Hasil pencarian "' + q + '"';
        navigateTo('search');
    }

    // --- RENDER GRID DENGAN SMART CENTERING ---
    function renderGrid() {
        const grid = document.getElementById('gridContainer');
        const empty = document.getElementById('emptyContainer');
        
        if(currentBooks.length === 0) { 
            grid.classList.add('hidden'); 
            empty.classList.replace('hidden', 'flex'); 
            return; 
        }
        
        grid.classList.remove('hidden'); 
        empty.classList.replace('flex', 'hidden');
        
        const count = currentBooks.length;
        
        // Logika layout adaptif agar posisinya cantik
        if (count === 1) {
            grid.className = "flex justify-center pt-[20px]";
        } else if (count === 2) {
            grid.className = "flex justify-center gap-[60px] pt-[20px]";
        } else {
            grid.className = "grid grid-cols-3 gap-[50px_30px]";
        }
        
        grid.innerHTML = currentBooks.map(b => `
            <div class="flex flex-col items-center gap-4 cursor-pointer group ${count <= 2 ? 'w-[220px]' : 'w-full'}" onclick="openDetail(${b.id})">
                <div class="w-full aspect-[2/3] rounded-[16px] overflow-hidden border border-slate-200 bg-white shadow-sm group-hover:shadow-xl group-hover:-translate-y-2 transition-all duration-300 shrink-0">
                    <img src="${b.img}" class="w-full h-full object-cover" onerror="this.src='https://placehold.co/400x600/ffffff/3730a3?text=Cover'">
                </div>
                <div class="w-full text-center px-2">
                    <div class="font-['Gelasio'] text-[24px] font-bold text-[#3730a3] leading-snug line-clamp-2">${b.title}</div>
                    <div class="font-['Inter'] text-[16px] text-slate-400 mt-1 uppercase tracking-widest truncate">${b.category}</div>
                </div>
            </div>
        `).join('');
    }

    function openDetail(id) {
        const b = dbBooks.find(x => x.id === id);
        if(!b) return;
        document.getElementById('dtlTitle').innerText = b.title;
        document.getElementById('dtlCall').innerText = b.callNum;
        document.getElementById('dtlCat').innerText = b.category;
        document.getElementById('dtlAuthor').innerText = b.author;
        document.getElementById('dtlPub').innerText = b.publisher;
        document.getElementById('dtlPhysical').innerText = b.physical;
        document.getElementById('dtlCover').src = b.img;
        navigateTo('detail');
    }

    function goBack() { handleSearch(); }
    function toggleCollFilter() { const m = document.getElementById('collFilterOverlay'); m.style.display = (m.style.display === 'flex') ? 'none' : 'flex'; }
    function applyFilterSearch(e) { e.preventDefault(); toggleCollFilter(); handleSearch(e); }

    setTimeout(() => navigateTo('home'), 150);
</#noparse>
</script>