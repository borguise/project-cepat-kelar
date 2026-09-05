<#-- =======================================================
     COLLECTIONS.FTL - KIOSK SPA (FINAL MASTERPIECE)
     Fitur: Standar OPAC, Tabel Detail Klasik-Modern, Full Data
     ======================================================= -->

<style>
    /* Menyembunyikan Scrollbar tapi tetap bisa digulir */
    .coll-scroll-area::-webkit-scrollbar { display: none; }
    .coll-scroll-area { scrollbar-width: none; overflow-y: auto; height: 100%; width: 100%; padding-bottom: 100px; position: relative; z-index: 10;}
    
    /* Latar Belakang Batik Khas Magetan */
    .coll-batik-layer {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
        background-size: 520px; opacity: 0.12; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    /* MODAL FILTER UI */
    .coll-filter-overlay { 
        position: absolute; inset: 0; 
        background: rgba(0, 0, 0, 0.75); z-index: 9999; 
        display: none; justify-content: center; align-items: center; 
    }
    
    .coll-filter-card {
        width: 600px; background: #ffffff; border-radius: 32px; padding: 50px; position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3); border: 1px solid rgba(255, 255, 255, 0.4);
    }
    .coll-filter-close { position: absolute; top: 35px; right: 40px; font-size: 40px; color: #94a3b8; cursor: pointer; transition: color 0.2s; }
    .coll-filter-close:hover { color: #3730a3; }
    .coll-filter-title { font-family: 'Inter', sans-serif; font-size: 42px; font-weight: 700; color: #1e293b; text-align: center; margin-bottom: 55px; }
    .coll-filter-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 45px 25px; margin-bottom: 60px; }
    .coll-filter-item { display: flex; align-items: center; gap: 20px; cursor: pointer; }
    .coll-checkbox-ui { width: 45px; height: 45px; border: 3px solid #cbd5e1; border-radius: 14px; display: flex; justify-content: center; align-items: center; background: #f8fafc; transition: all 0.2s ease; flex-shrink: 0; }
    
    .coll-filter-item input { display: none; }
    .coll-filter-item input:checked + .coll-checkbox-ui { background-color: #3730a3; border-color: #3730a3; box-shadow: 0 5px 15px rgba(55, 48, 163, 0.35); }
    .coll-checkbox-ui::after { content: "\f00c"; font-family: "Font Awesome 6 Free"; font-weight: 900; color: white; font-size: 22px; display: none; }
    .coll-filter-item input:checked + .coll-checkbox-ui::after { display: block; }
    
    .coll-label-text { font-family: 'Inter', sans-serif; font-size: 26px; color: #334155; font-weight: 500; }
    .coll-btn-apply { width: 100%; padding: 25px; background-color: #3730a3; color: white; border: none; border-radius: 20px; font-family: 'Inter', sans-serif; font-size: 30px; font-weight: 700; cursor: pointer; transition: transform 0.1s; }
    .coll-btn-apply:active { transform: scale(0.98); }
</style>

<div class="w-full h-full bg-[#f7f0cb] relative overflow-hidden font-['Inter']">
    
    <div class="coll-batik-layer"></div>

    <div class="coll-scroll-area flex flex-col items-center">
        
        <#-- ================= BROWSE VIEW ================= -->
        <div id="collViewBrowse" class="w-full max-w-[800px] flex flex-col items-center">
            
            <#-- Search Bar -->
            <div class="w-full mb-[50px] mt-[150px] relative">
                <form class="w-full h-[100px] bg-white rounded-[30px] flex items-center px-[40px] shadow-[0_10px_30px_rgba(0,0,0,0.08)]" onsubmit="collHandleSearch(event)">
                    <button type="submit" class="bg-transparent border-none cursor-pointer">
                        <i class="fas fa-search text-[40px] text-slate-300 mr-6"></i>
                    </button>
                    <input type="text" id="collSearchInput" class="flex-1 bg-transparent border-none outline-none text-center font-['Gelasio'] font-bold text-[34px] text-[#3730a3]" value="Cari Judul, Pengarang, Penerbit" autocomplete="off" onfocus="if(this.value=='Cari Judul, Pengarang, Penerbit')this.value=''">
                    
                    <i class="fas fa-tree text-[50px] text-[#065f46] ml-6 cursor-pointer hover:scale-110 transition-transform" onclick="collToggleFilter()"></i>
                </form>
            </div>

            <#-- Header Pencarian -->
            <div id="collSearchHeader" class="hidden w-full flex-col justify-center items-center mb-[40px] gap-3">
                <div id="collSearchTitle" class="font-['Gelasio'] font-bold text-[36px] text-slate-700 text-center w-full truncate">
                    Hasil pencarian
                </div>
                <div class="font-['Lato'] text-[20px] font-bold text-sky-500 cursor-pointer flex items-center gap-2 hover:text-sky-600 active:scale-95 transition bg-sky-50 px-5 py-2 rounded-full border border-sky-100 shadow-sm" onclick="collResetToHome()">
                    <i class="fas fa-times-circle"></i> Bersihkan pencarian
                </div>
            </div>

            <#-- White Card (Wadah Grid) -->
            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-sm min-h-[600px]">
                
                <div id="collGridContainer" class="grid grid-cols-3 gap-[50px_30px]"></div>
                
                <div id="collEmptyContainer" class="hidden flex-col items-center justify-center min-h-[500px] text-center gap-[40px]">
                    <div class="font-['Gelasio'] font-bold text-[46px] text-slate-800">Tidak Ditemukan</div>
                    <div class="w-[220px] h-[220px] rounded-full bg-slate-100 flex items-center justify-center text-slate-300 text-[110px] shadow-inner">
                        <i class="fas fa-search-minus"></i>
                    </div>
                    <p class="font-['Lato'] text-[28px] text-slate-500 px-10">Coba gunakan kata kunci lain.</p>
                </div>
            </div>
        </div>

        <#-- ================= DETAIL VIEW (TAMPILAN KATALOG STANDAR OPAC) ================= -->
        <div id="collViewDetail" class="hidden w-full max-w-[800px] flex-col items-center mt-[150px]">
            
            <#-- Tombol Kembali yang Ditengahkan dan Dihilangkan Tombol X nya -->
            <div class="w-full flex justify-center items-center mb-[25px] relative z-20 px-4">
                <div class="font-['Lato'] text-[26px] font-bold text-sky-500 cursor-pointer flex items-center gap-3 hover:text-sky-600 active:scale-95 transition bg-white px-8 py-3 rounded-full shadow-sm" onclick="collGoBack()">
                    <i class="fas fa-chevron-left"></i> Kembali ke daftar koleksi
                </div>
            </div>

            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-xl flex flex-col gap-[40px] mb-[80px]">
                
                <!-- Info Sampul & Judul Atas -->
                <div class="flex items-start gap-[50px]">
                    <div class="w-[240px] h-[340px] shrink-0 rounded-[12px] overflow-hidden border-[4px] border-slate-100 shadow-lg bg-slate-50 flex items-center justify-center">
                        <img id="collDtlCover" src="" class="w-full h-full object-cover" onerror="this.src='https://placehold.co/400x600/f1f5f9/94a3b8?text=Tidak+Ada+Cover'">
                    </div>
                    <div class="flex-1 flex flex-col pt-4">
                        <h1 id="collDtlTitle" class="font-['Gelasio'] font-bold text-[36px] leading-tight text-slate-900 mb-4 border-b-2 border-slate-200 pb-4">Judul</h1>
                        
                        <!-- Status Ketersediaan ala OPAC -->
                        <div class="mt-2 flex flex-col gap-2">
                            <span class="font-['Inter'] text-[18px] text-slate-500 font-semibold">Ketersediaan:</span>
                            <div class="flex items-center gap-3">
                                <span class="bg-sky-100 text-sky-700 font-bold px-4 py-2 rounded-lg text-[22px]" id="collDtlStock">0 Eks</span>
                                <span class="bg-green-100 text-green-700 font-bold px-4 py-2 rounded-lg text-[22px]">Tersedia</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="w-full">
                    <h2 class="font-['Gelasio'] font-bold text-[30px] text-slate-900 mb-6 flex items-center gap-4">
                        <i class="fas fa-info-circle text-sky-500"></i> Informasi Detail
                    </h2>
                    
                    <#-- TABEL INFORMASI DETAIL ALA OPAC NAMUN ELEGAN -->
                    <div class="bg-slate-50 rounded-[20px] p-[40px] border border-slate-200">
                        <table class="w-full text-left font-['Inter'] text-[24px] text-slate-700">
                            <tbody>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Judul Utama</td>
                                    <td class="py-5 font-bold align-top text-slate-900" id="collDtlTitleTable">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Pengarang</td>
                                    <td class="py-5 align-top" id="collDtlAuthor">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">No. Panggil</td>
                                    <td class="py-5 font-bold text-sky-700 align-top" id="collDtlCall">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Penerbitan</td>
                                    <td class="py-5 align-top" id="collDtlPub">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Deskripsi Fisik</td>
                                    <td class="py-5 align-top" id="collDtlPhysical">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Klasifikasi</td>
                                    <td class="py-5 align-top" id="collDtlCat">-</td>
                                </tr>
                                <tr>
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">ISBN/ISSN</td>
                                    <td class="py-5 align-top" id="collDtlIsbn">-</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <#-- ================= MODAL FILTER ================= -->
    <div id="collFilterOverlay" class="coll-filter-overlay" onclick="collToggleFilter()">
        <div class="coll-filter-card" onclick="event.stopPropagation()">
            <div class="coll-filter-close" onclick="collToggleFilter()"><i class="fas fa-times"></i></div>
            <h2 class="coll-filter-title">Filter Kategori</h2>
            <form onsubmit="collApplyFilterSearch(event)">
                <div class="coll-filter-grid">
                    <label class="coll-filter-item"><input type="checkbox" id="collChkJudul" checked><div class="coll-checkbox-ui"></div><span class="coll-label-text">Judul</span></label>
                    <label class="coll-filter-item"><input type="checkbox" id="collChkPengarang"><div class="coll-checkbox-ui"></div><span class="coll-label-text">Pengarang</span></label>
                    <label class="coll-filter-item"><input type="checkbox" id="collChkPenerbit"><div class="coll-checkbox-ui"></div><span class="coll-label-text">Penerbit</span></label>
                    <label class="coll-filter-item"><input type="checkbox" id="collChkIsbn"><div class="coll-checkbox-ui"></div><span class="coll-label-text">ISBN/Kategori</span></label>
                </div>
                <button type="submit" class="coll-btn-apply">Terapkan Filter</button>
            </form>
        </div>
    </div>

</div>

<script>
    const collBasePath = "${basePath!"/images/frontoffice"}";
    
    <#-- INJEKSI DATA DATABASE -->
    const collDbBooks = [
        <#if bookList?? && bookList?has_content>
            <#list bookList as b>
            { 
                id: ${b.id}, 
                title: "${(b.title!'Tanpa Judul')?js_string}", 
                callNum: "${(b.callNumber!'000.000')?js_string}", 
                category: "${(b.subject!'Koleksi')?js_string}", 
                author: "${(b.author!'Anonim')?js_string}", 
                publisher: "${(b.publisher!'-')?js_string}", 
                pubCity: "${(b.publishCity!'')?js_string}", 
                pubYear: "${(b.publishYear!'')?js_string}", 
                physical: "${(b.physicalDescription!'-')?js_string}",
                isbn: "${(b.isbn!'')?js_string}",
                stock: ${(b.stock!0)?c},
                img: "/admin/collections/image/${b.id}" 
            }<#if b?has_next>,</#if>
            </#list>
        <#else>
            { id: 1, title: "Seni Memahami Literasi", callNum: "899.221", category: "Buku Umum", author: "Pemerintah Kab. Magetan", publisher: "Graha Literasi", pubCity: "Magetan", pubYear: "2024", physical: "xiv, 250 hlm ; 24 cm", isbn: "978-602-123-456-7", stock: 5, img: "https://placehold.co/400x600/ffffff/3730a3?text=Buku+1" }
        </#if>
    ];

<#noparse>
    let collCurrentBooks = [...collDbBooks];

    function collNavigateTo(view) {
        document.getElementById('collViewBrowse').classList.toggle('hidden', view !== 'home' && view !== 'search');
        document.getElementById('collViewBrowse').classList.toggle('flex', view === 'home' || view === 'search');
        document.getElementById('collViewDetail').classList.toggle('hidden', view !== 'detail');
        document.getElementById('collViewDetail').classList.toggle('flex', view === 'detail');
        
        if(view !== 'detail') {
            document.getElementById('collSearchHeader').classList.toggle('hidden', view === 'home');
            document.getElementById('collSearchHeader').classList.toggle('flex', view === 'search');
            collRenderGrid();
        }
    }

    function collResetToHome() {
        document.getElementById('collSearchInput').value = 'Cari Judul, Pengarang, Penerbit';
        collCurrentBooks = [...collDbBooks];
        collNavigateTo('home');
    }

    function collHandleSearch(e) {
        if(e) e.preventDefault();
        const q = document.getElementById('collSearchInput').value.trim().toLowerCase();
        if(q === '' || q === 'cari judul, pengarang, penerbit') { collResetToHome(); return; }
        
        const fJudul = document.getElementById('collChkJudul').checked;
        const fPengarang = document.getElementById('collChkPengarang').checked;
        const fPenerbit = document.getElementById('collChkPenerbit').checked;
        const fIsbn = document.getElementById('collChkIsbn').checked;

        collCurrentBooks = collDbBooks.filter(b => {
            if(!fJudul && !fPengarang && !fPenerbit && !fIsbn) return false;
            let match = false;
            if (fJudul && b.title.toLowerCase().includes(q)) match = true;
            if (fPengarang && b.author.toLowerCase().includes(q)) match = true;
            if (fPenerbit && b.publisher.toLowerCase().includes(q)) match = true;
            if (fIsbn && (b.callNum.toLowerCase().includes(q) || b.category.toLowerCase().includes(q) || b.isbn.toLowerCase().includes(q))) match = true;
            return match;
        });
        
        document.getElementById('collSearchTitle').innerText = 'Hasil pencarian "' + document.getElementById('collSearchInput').value + '"';
        collNavigateTo('search');
    }

    function collRenderGrid() {
        const grid = document.getElementById('collGridContainer');
        const empty = document.getElementById('collEmptyContainer');
        
        if(collCurrentBooks.length === 0) { 
            grid.classList.add('hidden'); 
            empty.classList.replace('hidden', 'flex'); 
            return; 
        }
        
        grid.classList.remove('hidden'); 
        empty.classList.replace('flex', 'hidden');
        
        const count = collCurrentBooks.length;
        
        if (count === 1) { grid.className = "flex justify-center pt-[20px]"; } 
        else if (count === 2) { grid.className = "flex justify-center gap-[60px] pt-[20px]"; } 
        else { grid.className = "grid grid-cols-3 gap-[50px_30px]"; }
        
        grid.innerHTML = collCurrentBooks.map(b => `
            <div class="flex flex-col items-center gap-4 cursor-pointer group ${count <= 2 ? 'w-[220px]' : 'w-full'}" onclick="collOpenDetail(${b.id})">
                <div class="w-full aspect-[2/3] rounded-[16px] overflow-hidden border border-slate-200 bg-white shadow-sm group-hover:shadow-xl group-hover:-translate-y-2 transition-all duration-300 shrink-0">
                    <img src="${b.img}" class="w-full h-full object-cover" onerror="this.src='https://placehold.co/400x600/f1f5f9/94a3b8?text=Cover'">
                </div>
                <div class="w-full text-center px-2">
                    <div class="font-['Gelasio'] text-[24px] font-bold text-[#3730a3] leading-snug line-clamp-2">${b.title}</div>
                    <div class="font-['Inter'] text-[16px] text-slate-400 mt-1 uppercase tracking-widest truncate">${b.category}</div>
                </div>
            </div>
        `).join('');
    }

    function collOpenDetail(id) {
        const b = collDbBooks.find(x => x.id === id);
        if(!b) return;
        
        // Header
        document.getElementById('collDtlTitle').innerText = b.title;
        document.getElementById('collDtlStock').innerText = b.stock + " Eks";
        
        // Tabel OPAC Klasik
        document.getElementById('collDtlTitleTable').innerText = b.title;
        document.getElementById('collDtlAuthor').innerText = b.author;
        document.getElementById('collDtlCall').innerText = b.callNum;
        document.getElementById('collDtlPhysical').innerText = b.physical;
        document.getElementById('collDtlCat').innerText = b.category;
        document.getElementById('collDtlIsbn').innerText = (b.isbn && b.isbn.trim() !== "") ? b.isbn : "-";
        
        // FORMAT DATA PUBLIKASI STANDAR KATALOG (Kota : Penerbit, Tahun)
        let pubText = "";
        if (b.pubCity && b.pubCity.trim() !== "") pubText += b.pubCity + " : ";
        pubText += b.publisher;
        if (b.pubYear && b.pubYear.trim() !== "") pubText += ", " + b.pubYear;
        
        document.getElementById('collDtlPub').innerText = pubText !== "" ? pubText : "-";
        document.getElementById('collDtlCover').src = b.img;
        
        collNavigateTo('detail');
    }

    function collGoBack() { collHandleSearch(); }
    function collToggleFilter() { const m = document.getElementById('collFilterOverlay'); m.style.display = (m.style.display === 'flex') ? 'none' : 'flex'; }
    function collApplyFilterSearch(e) { e.preventDefault(); collToggleFilter(); collHandleSearch(e); }

    setTimeout(() => collNavigateTo('home'), 150);
</#noparse>
</script>