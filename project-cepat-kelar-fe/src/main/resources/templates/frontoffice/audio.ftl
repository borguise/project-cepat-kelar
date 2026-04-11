<#-- =======================================================
     AUDIO.FTL - ULTIMATE SPA (CHECKBOX FILTER UPDATE)
     Fitur: Checkbox UI, Multi-select Search Logic
     ======================================================= -->

<style>
    /* Menyembunyikan Scrollbar tapi tetap bisa digulir (Scrollable) */
    .aud-scroll-area::-webkit-scrollbar { display: none; }
    .aud-scroll-area { scrollbar-width: none; overflow-y: auto; height: 100%; width: 100%; padding-bottom: 100px;}
    
    /* Animasi Piringan Hitam */
    .aud-spin { animation: spin 8s linear infinite; border-radius: 50% !important; border: 12px solid #1a1a1a !important; }
    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

    /* ========================================================
       MODAL FILTER CHECKBOX UI (DESAIN BARU)
       ======================================================== */
    .aud-filter-overlay { 
        position: absolute; inset: 0; background: rgba(0,0,0,0.5); 
        backdrop-filter: blur(8px); z-index: 9999; 
        display: none; justify-content: center; align-items: center; 
    }
    
    .aud-filter-card {
        width: 600px; background: #ffffff; border-radius: 32px;
        padding: 50px; position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.4);
    }

    .aud-filter-close {
        position: absolute; top: 35px; right: 40px;
        font-size: 40px; color: #94a3b8; cursor: pointer;
        transition: color 0.2s; font-family: 'Inter', sans-serif;
    }

    .aud-filter-title {
        font-family: 'Inter', sans-serif;
        font-size: 42px; font-weight: 700; color: #1e293b;
        text-align: center; margin-bottom: 55px;
    }

    .aud-filter-grid {
        display: grid; grid-template-columns: 1fr 1fr;
        gap: 45px 25px; margin-bottom: 60px;
    }

    .aud-filter-item {
        display: flex; align-items: center; 
        gap: 20px; cursor: pointer;
    }

    /* Kotak Checkbox Kosong */
    .aud-checkbox-ui {
        width: 45px; height: 45px;
        border: 3px solid #cbd5e1; border-radius: 14px;
        display: flex; justify-content: center; align-items: center;
        background: #f8fafc; transition: all 0.2s ease; flex-shrink: 0;
    }

    .aud-filter-item input { display: none; }

    /* State Tercentang */
    .aud-filter-item input:checked + .aud-checkbox-ui {
        background-color: #3730a3; 
        border-color: #3730a3;
        box-shadow: 0 5px 15px rgba(55, 48, 163, 0.35);
    }

    /* Icon Centang (Pakai pseudo element agar tidak pakai tag <i>) */
    .aud-checkbox-ui::after {
        content: "\f00c"; font-family: "Font Awesome 6 Free";
        font-weight: 900; color: white; font-size: 22px; display: none;
    }
    .aud-filter-item input:checked + .aud-checkbox-ui::after { display: block; }

    .aud-label-text { 
        font-family: 'Inter', sans-serif;
        font-size: 26px; color: #334155; font-weight: 500; 
        line-height: 1.3;
    }

    .aud-btn-apply {
        width: 100%; padding: 25px;
        background-color: #3730a3; color: white;
        border: none; border-radius: 20px;
        font-family: 'Inter', sans-serif;
        font-size: 30px; font-weight: 700; cursor: pointer;
        box-shadow: 0 10px 30px rgba(55, 48, 163, 0.3); transition: transform 0.1s;
    }
    .aud-btn-apply:active { transform: scale(0.98); }
</style>

<#-- ROOT CONTAINER (Krem Background) -->
<div class="w-full h-full bg-[#F7F3EE] relative overflow-hidden font-['Inter']">
    
    <audio id="audioEngine"></audio>

    <div class="aud-scroll-area pt-[50px] px-[50px] flex flex-col items-center">
        
        <#-- ================= BROWSE VIEW (HOME & SEARCH) ================= -->
        <div id="viewBrowse" class="w-full max-w-[800px] flex flex-col items-center">
            
            <#-- Search Bar Raksasa -->
            <div class="w-full max-w-[800px] mb-[50px] mt-[150px] relative">
                <form class="w-full h-[100px] bg-white rounded-[30px] flex items-center px-[40px] shadow-[0_10px_30px_rgba(0,0,0,0.05)]" onsubmit="handleSearch(event)">
                    <button type="submit" class="bg-transparent border-none cursor-pointer">
                        <i class="fas fa-search text-[45px] text-slate-300 mr-6"></i>
                    </button>
                    <input type="text" id="searchInput" class="flex-1 bg-transparent border-none outline-none text-center font-['Gelasio'] font-bold text-[38px] text-[#3730a3]" value="Koleksi Audio & Podcast" autocomplete="off" onfocus="if(this.value=='Koleksi Audio & Podcast')this.value=''">
                    <i class="fas fa-tree text-[55px] text-green-700 ml-6 cursor-pointer" onclick="toggleAudFilter()"></i>
                </form>
            </div>

            <#-- Header Pencarian (Tanpa Tombol Kembali) -->
            <div id="searchHeader" class="hidden w-full flex justify-center items-center mb-[40px]">
                <div id="searchTitle" class="font-['Gelasio'] font-bold text-[36px] text-slate-700 text-center w-full truncate">
                    Hasil pencarian
                </div>
            </div>

            <#-- Featured Player (Hanya Muncul di Home) -->
            <div id="homeFeatured" class="w-full flex items-center gap-[50px] mb-[60px]">
                <img id="hmCover" src="" class="w-[320px] h-[320px] rounded-[24px] border-[8px] border-[#3d6b4d] object-cover bg-[#eef2eb] shadow-xl shrink-0" alt="Cover">
                <div class="flex-1 flex flex-col justify-center">
                    <h1 id="hmTitle" class="font-['Gelasio'] font-bold text-[46px] leading-[1.2] text-[#1a1a1a] mb-[20px]">Memuat...</h1>
                    <p id="hmDesc" class="text-[24px] text-slate-500">Mohon tunggu...</p>
                    
                    <#-- Progress Bar -->
                    <div class="w-full flex items-center gap-[20px] mt-[40px] mb-[40px]">
                        <span id="hmCur" class="font-bold text-[26px] text-slate-800 w-[80px] text-center">00:00</span>
                        <div class="flex-1 h-[14px] bg-slate-300 rounded-[10px] relative cursor-pointer" onclick="seekAudio(event)">
                            <div id="hmFill" class="absolute left-0 top-0 bottom-0 bg-[#3730a3] rounded-[10px] w-0 transition-all duration-200 pointer-events-none">
                                <div class="absolute right-[-15px] top-[-6px] w-[30px] h-[26px] bg-[#3730a3] rounded-full border-[3px] border-white shadow-md"></div>
                            </div>
                        </div>
                        <span id="hmTot" class="font-bold text-[26px] text-slate-800 w-[80px] text-center">00:00</span>
                    </div>

                    <#-- Controls -->
                    <div class="w-full flex justify-center items-center gap-[60px]">
                        <i class="fas fa-step-backward text-[60px] cursor-pointer text-slate-800 active:scale-95" onclick="prevTrack()"></i>
                        <i id="hmPlayBtn" class="fas fa-play text-[90px] cursor-pointer text-slate-800 active:scale-95" onclick="togglePlay()"></i>
                        <i class="fas fa-step-forward text-[60px] cursor-pointer text-slate-800 active:scale-95" onclick="nextTrack()"></i>
                    </div>
                </div>
            </div>

            <#-- Kartu Putih Bawah (Playlist Grid atau Kosong) -->
            <div class="w-full bg-white rounded-[40px] p-[50px] shadow-sm">
                <div id="gridContainer" class="grid grid-cols-2 gap-[30px]"></div>
                
                <#-- Wadah Not Found (Dengan min-height proporsional) -->
                <div id="emptyContainer" class="hidden flex-col items-center justify-center min-h-[500px] text-center gap-[40px]">
                    <div class="font-['Gelasio'] font-bold text-[46px] text-slate-800">Tidak Ditemukan</div>
                    <div class="w-[220px] h-[220px] rounded-full bg-slate-100 flex items-center justify-center text-slate-300 text-[110px] shadow-inner">
                        <i class="fas fa-search-minus"></i>
                    </div>
                    <p class="font-['Lato'] text-[28px] text-slate-400 px-10 leading-relaxed">
                        Coba periksa kembali ejaan atau<br>gunakan kata kunci lain.
                    </p>
                </div>
            </div>
        </div>

        <#-- ================= DETAIL VIEW ================= -->
        <div id="viewDetail" class="hidden w-full max-w-[800px] flex-col items-center">
            
            <#-- Posisi Tombol Kembali di LUAR Kartu Putih -->
            <div class="w-full flex justify-start mb-[25px]">
                <div class="font-['Lato'] text-[26px] font-bold text-sky-500 cursor-pointer flex items-center gap-3 hover:text-sky-600 active:scale-95 transition" onclick="goBack()">
                    <i class="fas fa-chevron-left"></i> Kembali ke daftar audio
                </div>
            </div>

            <#-- Kartu Konten Utama -->
            <div class="w-full bg-white rounded-[40px] p-[50px] shadow-md flex flex-col gap-[40px]">
                
                <#-- Konten Detail -->
                <div class="flex items-center gap-[50px]">
                    <img id="dtlCover" src="" class="w-[300px] h-[300px] rounded-[24px] border-[4px] border-slate-100 object-cover bg-slate-200 shrink-0 transition-all duration-300" alt="Cover">
                    <div class="flex-1 flex flex-col justify-center text-center">
                        <h1 id="dtlTitle" class="font-['Gelasio'] font-bold text-[40px] leading-tight text-slate-900 mb-2">Judul</h1>
                        <div id="dtlCall" class="font-['Gelasio'] font-bold text-[55px] text-black">000</div>
                        <div id="dtlCat" class="font-['Gelasio'] font-bold text-[30px] text-slate-400 uppercase tracking-widest mt-2">Kategori</div>
                    </div>
                </div>

                <#-- Detail Player -->
                <div class="w-full bg-slate-50 rounded-[30px] border-2 border-slate-100 p-[40px] flex flex-col gap-[40px]">
                    <div class="flex justify-between items-center text-[28px] font-bold text-slate-800">
                        <span id="dtlCur">00:00</span>
                        <div class="flex-1 mx-[40px] h-[14px] bg-slate-300 rounded-[10px] relative cursor-pointer" onclick="seekAudio(event)">
                            <div id="dtlFill" class="absolute left-0 top-0 bottom-0 bg-[#3730a3] rounded-[10px] w-0 pointer-events-none"></div>
                        </div>
                        <span id="dtlTot">00:00</span>
                    </div>
                    <div class="flex justify-center items-center gap-[80px]">
                        <i class="fas fa-undo text-[55px] text-slate-300 cursor-pointer active:scale-95" onclick="jump(-10)"></i>
                        <i id="dtlPlayBtn" class="fas fa-play text-[100px] text-indigo-800 cursor-pointer active:scale-95" onclick="togglePlay()"></i>
                        <i class="fas fa-redo text-[55px] text-slate-300 cursor-pointer active:scale-95" onclick="jump(10)"></i>
                    </div>
                </div>

                <#-- Keterangan Detail -->
                <div class="w-full">
                    <h2 class="font-['Gelasio'] font-bold text-[36px] text-slate-900 mb-[30px] border-b-4 border-slate-100 pb-4 inline-block">Keterangan</h2>
                    <div class="flex flex-col gap-[20px]">
                        <div class="bg-white rounded-[20px] p-[25px] border-2 border-slate-100 flex flex-col gap-2">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase">Pengisi suara / Pencipta</div>
                            <div id="dtlAuthor" class="font-['Gelasio'] font-bold text-[32px] text-slate-800">Nama</div>
                        </div>
                        <div class="bg-white rounded-[20px] p-[25px] border-2 border-slate-100 flex flex-col gap-2">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase">Data Penerbit</div>
                            <div id="dtlPub" class="font-['Gelasio'] font-bold text-[32px] text-slate-800">Penerbit</div>
                        </div>
                        <div class="bg-white rounded-[20px] p-[25px] border-2 border-slate-100 flex flex-col gap-2">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase">Data Fisik</div>
                            <div id="dtlPhysical" class="font-['Gelasio'] font-bold text-[32px] text-slate-800 flex gap-8">
                                <span>-</span> <span>-</span> <span>-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#-- ================= MODAL FILTER (DESAIN CHECKBOX) ================= -->
    <div id="audFilterOverlay" class="aud-filter-overlay" onclick="toggleAudFilter()">
        <div class="aud-filter-card" onclick="event.stopPropagation()">
            <div class="aud-filter-close" onclick="toggleAudFilter()"><i class="fas fa-times"></i></div>
            <h2 class="aud-filter-title">Filter Kategori</h2>

            <form onsubmit="applyFilterSearch(event)">
                <div class="aud-filter-grid">
                    <label class="aud-filter-item">
                        <input type="checkbox" id="chkJudul" value="judul" checked>
                        <div class="aud-checkbox-ui"></div>
                        <span class="aud-label-text">Judul</span>
                    </label>

                    <label class="aud-filter-item">
                        <input type="checkbox" id="chkInstansi" value="instansi">
                        <div class="aud-checkbox-ui"></div>
                        <span class="aud-label-text">Label /<br>instansi</span>
                    </label>

                    <label class="aud-filter-item">
                        <input type="checkbox" id="chkIsbn" value="isbn">
                        <div class="aud-checkbox-ui"></div>
                        <span class="aud-label-text">ISBN/Kategori</span>
                    </label>

                    <label class="aud-filter-item">
                        <input type="checkbox" id="chkPengisi" value="pengisi">
                        <div class="aud-checkbox-ui"></div>
                        <span class="aud-label-text">Pengisi<br>suara</span>
                    </label>
                </div>

                <button type="submit" class="aud-btn-apply">Terapkan Filter</button>
            </form>
        </div>
    </div>

</div>

<script>
    <#-- DATA INJECTION BASEPATH & DATABASE -->
    const basePath = "${basePath!"/images/frontoffice"}";

    const dbTracks = [
        <#if audioList?? && audioList?has_content>
            <#list audioList as audio>
            {
                id: ${audio?index},
                title: "${(audio.title!'Tanpa Judul')?js_string}",
                desc: "${(audio.description!'Tidak ada deskripsi')?js_string}",
                callNum: "${(audio.callNumber!'000')?js_string}",
                category: "${(audio.category!'Audio')?js_string}",
                author: "${(audio.author!'Anonim')?js_string}",
                publisher: "${(audio.publisher!'-')?js_string}",
                physical: ["${(audio.duration!'-')?js_string}", "${(audio.format!'-')?js_string}", "1 rekaman"],
                img: "${(audio.coverUrl!'https://placehold.co/400x400/eef2eb/3d6b4d?text=Cover')?js_string}"
            }<#if audio?has_next>,</#if>
            </#list>
        <#else>
            { id: 0, title: "Mars Perpustakaan Nasional", desc: "Lagu resmi tanpa vokal.", callNum: "782.421", category: "Musik", author: "Pemerintah RI", publisher: "Perpusnas, 2020", physical: ["3 menit", "MP3", "1 rekaman"], img: "https://placehold.co/400x400/eef2eb/3d6b4d?text=Mars" },
            { id: 1, title: "Indonesia Raya", desc: "Lagu Kebangsaan Indonesia.", callNum: "782.421", category: "Musik", author: "W.R. Soepratman", publisher: "Sin Po, 1928", physical: ["4 menit", "MP3", "1 rekaman"], img: "https://placehold.co/400x400/eef2eb/3d6b4d?text=Indonesia" },
            { id: 2, title: "Daftar Anggota", desc: "Panduan mendaftar anggota.", callNum: "020.11", category: "Panduan", author: "Admin Literasi", publisher: "Graha Magetan, 2024", physical: ["5 menit", "WAV", "1 rekaman"], img: "https://placehold.co/400x400/eef2eb/3d6b4d?text=Panduan" },
            { id: 3, title: "Cara Meminjam", desc: "Penjelasan meminjam buku.", callNum: "020.12", category: "Panduan", author: "Admin Literasi", publisher: "Graha Magetan, 2024", physical: ["2 menit", "WAV", "1 rekaman"], img: "https://placehold.co/400x400/eef2eb/3d6b4d?text=Pinjam" }
        </#if>
    ];

<#noparse>
    let currentTracks = [...dbTracks];
    let activeIdx = 0;
    let isPlaying = false;
    let simProgress = 0;
    let simTimer = null;
    let currentView = 'home'; 

    // --- Reset Keseluruhan ---
    window.stopAudioFragment = function() {
        isPlaying = false; 
        clearInterval(simTimer);
        syncUI();
        resetToHome(); 
    };

    function resetToHome() {
        document.getElementById('searchInput').value = 'Koleksi Audio & Podcast';
        currentTracks = [...dbTracks];
        navigateTo('home');
    }

    function navigateTo(view) {
        currentView = view;
        const vBrowse = document.getElementById('viewBrowse');
        const vDetail = document.getElementById('viewDetail');
        
        if(view === 'home' || view === 'search') {
            vBrowse.classList.remove('hidden');
            vBrowse.classList.add('flex');
            vDetail.classList.add('hidden');
            vDetail.classList.remove('flex');
            
            if(view === 'home') {
                document.getElementById('searchHeader').classList.add('hidden');
                document.getElementById('searchHeader').classList.remove('flex');
                document.getElementById('homeFeatured').classList.remove('hidden');
                document.getElementById('emptyContainer').classList.add('hidden');
                document.getElementById('gridContainer').classList.remove('hidden');
                renderGrid();
            } else if(view === 'search') {
                document.getElementById('searchHeader').classList.remove('hidden');
                document.getElementById('searchHeader').classList.add('flex');
                document.getElementById('homeFeatured').classList.add('hidden'); 
                
                if(currentTracks.length > 0) {
                    document.getElementById('gridContainer').classList.remove('hidden');
                    document.getElementById('emptyContainer').classList.add('hidden');
                    renderGrid();
                } else {
                    document.getElementById('gridContainer').classList.add('hidden');
                    document.getElementById('emptyContainer').classList.remove('hidden');
                    document.getElementById('emptyContainer').classList.add('flex');
                }
            }
        } else if(view === 'detail') {
            vBrowse.classList.add('hidden');
            vBrowse.classList.remove('flex');
            vDetail.classList.remove('hidden');
            vDetail.classList.add('flex');
            renderDetail();
        }
        syncUI();
    }

    // --- SEARCH ENGINE DENGAN LOGIKA CHECKBOX ---
    function handleSearch(e) {
        if(e) e.preventDefault(); // Mencegah form reload default

        const query = document.getElementById('searchInput').value.trim().toLowerCase();
        if(query === '' || query === 'koleksi audio & podcast') { resetToHome(); return; }
        
        document.getElementById('searchTitle').innerText = 'Hasil pencarian "' + document.getElementById('searchInput').value + '"';
        
        // Ambil status centang
        const isJudul = document.getElementById('chkJudul').checked;
        const isInstansi = document.getElementById('chkInstansi').checked;
        const isIsbn = document.getElementById('chkIsbn').checked;
        const isPengisi = document.getElementById('chkPengisi').checked;

        // Logika Multi-Filter SPA
        currentTracks = dbTracks.filter(t => {
            // Jika tidak ada yang dicentang, jangan keluarkan hasil
            if(!isJudul && !isInstansi && !isIsbn && !isPengisi) return false;

            let match = false;
            if (isJudul && t.title.toLowerCase().includes(query)) match = true;
            if (isInstansi && t.publisher.toLowerCase().includes(query)) match = true;
            if (isIsbn && (t.callNum.toLowerCase().includes(query) || t.category.toLowerCase().includes(query))) match = true;
            if (isPengisi && t.author.toLowerCase().includes(query)) match = true;
            
            return match;
        });
        
        navigateTo('search');
    }

    function goBack() {
        const val = document.getElementById('searchInput').value;
        if(val === 'Koleksi Audio & Podcast' || val === '') navigateTo('home');
        else navigateTo('search');
    }

    function renderGrid() {
        const grid = document.getElementById('gridContainer');
        let html = "";
        let isSingleItem = currentTracks.length === 1; 
        
        for(let i=0; i<currentTracks.length; i++) {
            let t = currentTracks[i];
            let isActive = (t.id === activeIdx) ? "bg-[#eef2ff] border-[#3730a3]" : "bg-[#f8fafc] border-transparent";
            let isSpin = (t.id === activeIdx && isPlaying) ? "aud-spin" : "";
            let singleStyle = isSingleItem ? 'style="max-width: 450px; margin: 0 auto;"' : '';
            
            html += '<div class="flex items-center gap-[25px] p-[20px] rounded-[25px] border-[2px] transition-all cursor-pointer ' + isActive + '" ' + singleStyle + ' onclick="openDetail(' + t.id + ')">' +
                    '<div class="w-[90px] h-[90px] bg-[#1a1a1a] rounded-full flex justify-center items-center shrink-0 border-[3px] border-[#e2e8f0] ' + isSpin + '" id="vynil-' + t.id + '"><div class="w-[16px] h-[16px] bg-white rounded-full"></div></div>' +
                    '<div style="flex: 1; overflow: hidden;">' +
                    '<div class="font-[\'Inter\'] text-[24px] font-bold text-[#1e293b] leading-tight truncate">' + t.title + '</div>' +
                    '<div class="font-[\'Inter\'] text-[18px] text-slate-500 mt-1 truncate">' + t.desc + '</div>' +
                    '</div></div>';
        }
        grid.style.display = isSingleItem ? "block" : "grid";
        grid.innerHTML = html;
    }

    function openDetail(trackId) {
        if(activeIdx !== trackId) { activeIdx = trackId; simProgress = 0; }
        navigateTo('detail');
    }

    function renderDetail() {
        const t = dbTracks.find(x => x.id === activeIdx);
        document.getElementById('dtlTitle').innerText = t.title;
        document.getElementById('dtlCall').innerText = t.callNum;
        document.getElementById('dtlCat').innerText = t.category;
        document.getElementById('dtlAuthor').innerText = t.author;
        document.getElementById('dtlPub').innerText = t.publisher;
        document.getElementById('dtlCover').src = t.img;
        document.getElementById('dtlPhysical').innerHTML = '<span>' + t.physical[0] + '</span> <span>' + t.physical[1] + '</span> <span>' + t.physical[2] + '</span>';
        syncUI();
    }

    function syncUI() {
        const t = dbTracks.find(x => x.id === activeIdx);
        if(t) {
            document.getElementById('hmTitle').innerText = t.title;
            document.getElementById('hmDesc').innerText = t.desc.substring(0, 40) + '...';
            document.getElementById('hmCover').src = t.img;
        }
        
        let p = simProgress + "%";
        document.getElementById('hmFill').style.width = p;
        document.getElementById('dtlFill').style.width = p;
        document.getElementById('hmCur').innerText = fmt((simProgress/100)*225);
        document.getElementById('dtlCur').innerText = fmt((simProgress/100)*225);

        const playIco = isPlaying ? 'fa-pause' : 'fa-play';
        document.getElementById('hmPlayBtn').className = "fas " + playIco + " text-[90px] cursor-pointer text-slate-800 active:scale-95 transition";
        document.getElementById('dtlPlayBtn').className = "fas " + playIco + " text-[100px] text-indigo-800 cursor-pointer active:scale-95 transition";
        
        if(isPlaying) document.getElementById('dtlCover').classList.add('aud-spin');
        else document.getElementById('dtlCover').classList.remove('aud-spin');

        renderGrid();
    }

    function togglePlay() {
        isPlaying = !isPlaying;
        if(isPlaying) {
            simTimer = setInterval(() => {
                simProgress += 0.5;
                if(simProgress >= 100) { simProgress = 0; togglePlay(); return; }
                syncUI();
            }, 1000);
        } else { clearInterval(simTimer); }
        syncUI();
    }

    function nextTrack() { activeIdx = (activeIdx + 1) % dbTracks.length; simProgress = 0; syncUI(); if(currentView === 'detail') renderDetail(); }
    function prevTrack() { activeIdx = (activeIdx - 1 + dbTracks.length) % dbTracks.length; simProgress = 0; syncUI(); if(currentView === 'detail') renderDetail(); }
    
    function jump(s) {
        if(isPlaying || simProgress > 0) {
            simProgress += (s > 0) ? 5 : -5; 
            if(simProgress < 0) simProgress = 0;
            if(simProgress > 100) simProgress = 100;
            syncUI();
        }
    }

    function seekAudio(e) {
        const rect = e.currentTarget.getBoundingClientRect();
        simProgress = ((e.clientX - rect.left) / rect.width) * 100;
        syncUI();
    }

    function fmt(s) { let m = Math.floor(s / 60), sc = Math.floor(s % 60); return (m < 10 ? "0" + m : m) + ":" + (sc < 10 ? "0" + sc : sc); }

    function toggleAudFilter() {
        const m = document.getElementById('audFilterOverlay');
        m.style.display = (m.style.display === 'flex') ? 'none' : 'flex';
    }

    // Menggabungkan Modal Filter dan Pencarian
    function applyFilterSearch(e) {
        e.preventDefault();
        toggleAudFilter(); // Tutup modal setelah filter ditetapkan
        handleSearch(e);   // Eksekusi ulang pencarian yang ada di search box dengan filter baru
    }

    setTimeout(() => { resetToHome(); }, 150);
</#noparse>
</script>