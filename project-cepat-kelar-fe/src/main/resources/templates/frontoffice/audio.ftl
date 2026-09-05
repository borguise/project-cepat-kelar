<#-- =======================================================
     AUDIO.FTL - ULTIMATE SPA (FINAL INTEGRATED CODE)
     ======================================================= -->

<style>
    .aud-scroll-area::-webkit-scrollbar { display: none; }
    .aud-scroll-area { scrollbar-width: none; overflow-y: auto; height: 100%; width: 100%; padding-bottom: 100px;}
    
    .aud-spin { animation: spin 8s linear infinite; border-radius: 50% !important; border: 12px solid #1a1a1a !important; }
    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

    .aud-filter-overlay { 
        position: absolute; inset: 0; background: rgba(0, 0, 0, 0.75); 
        z-index: 9999; display: none; justify-content: center; align-items: center; 
    }
    
    .aud-filter-card {
        width: 600px; background: #ffffff; border-radius: 32px; padding: 50px; position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3); border: 1px solid rgba(255, 255, 255, 0.4);
    }
    .aud-filter-close { position: absolute; top: 35px; right: 40px; font-size: 40px; color: #94a3b8; cursor: pointer; transition: color 0.2s; font-family: 'Inter', sans-serif; }
    .aud-filter-title { font-family: 'Inter', sans-serif; font-size: 42px; font-weight: 700; color: #1e293b; text-align: center; margin-bottom: 55px; }
    .aud-filter-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 45px 25px; margin-bottom: 60px; }
    .aud-filter-item { display: flex; align-items: center; gap: 20px; cursor: pointer; }
    .aud-checkbox-ui { width: 45px; height: 45px; border: 3px solid #cbd5e1; border-radius: 14px; display: flex; justify-content: center; align-items: center; background: #f8fafc; transition: all 0.2s ease; flex-shrink: 0; }
    .aud-filter-item input { display: none; }
    .aud-filter-item input:checked + .aud-checkbox-ui { background-color: #3730a3; border-color: #3730a3; box-shadow: 0 5px 15px rgba(55, 48, 163, 0.35); }
    .aud-checkbox-ui::after { content: "\f00c"; font-family: "Font Awesome 6 Free"; font-weight: 900; color: white; font-size: 22px; display: none; }
    .aud-filter-item input:checked + .aud-checkbox-ui::after { display: block; }
    .aud-label-text { font-family: 'Inter', sans-serif; font-size: 26px; color: #334155; font-weight: 500; line-height: 1.3; }
    .aud-btn-apply { width: 100%; padding: 25px; background-color: #3730a3; color: white; border: none; border-radius: 20px; font-family: 'Inter', sans-serif; font-size: 30px; font-weight: 700; cursor: pointer; box-shadow: 0 10px 30px rgba(55, 48, 163, 0.3); transition: transform 0.1s; }
    .aud-btn-apply:active { transform: scale(0.98); }
</style>

<div class="w-full h-full bg-[#F7F3EE] relative overflow-hidden font-['Inter']">
    
    <audio id="audioEngine" preload="auto"></audio>

    <div class="aud-scroll-area pt-[50px] px-[50px] flex flex-col items-center">
        
        <!-- BROWSE VIEW -->
        <div id="viewBrowse" class="w-full max-w-[800px] flex flex-col items-center">
            
            <div class="w-full max-w-[800px] mb-[50px] mt-[150px] relative">
                <form class="w-full h-[100px] bg-white rounded-[30px] flex items-center px-[40px] shadow-[0_10px_30px_rgba(0,0,0,0.05)]" onsubmit="handleSearch(event)">
                    <button type="submit" class="bg-transparent border-none cursor-pointer">
                        <i class="fas fa-search text-[45px] text-slate-300 mr-6"></i>
                    </button>
                    <input type="text" id="searchInput" class="flex-1 bg-transparent border-none outline-none text-center font-['Gelasio'] font-bold text-[38px] text-[#3730a3]" value="Koleksi Audio & Podcast" autocomplete="off" onfocus="if(this.value=='Koleksi Audio & Podcast')this.value=''">
                    <i class="fas fa-tree text-[55px] text-green-700 ml-6 cursor-pointer" onclick="toggleAudFilter()"></i>
                </form>
            </div>

            <div id="searchHeader" class="hidden w-full flex-col justify-center items-center mb-[40px] gap-3">
                <div id="searchTitle" class="font-['Gelasio'] font-bold text-[36px] text-slate-700 text-center w-full truncate">
                    Hasil pencarian
                </div>
                <div class="font-['Lato'] text-[20px] font-bold text-sky-500 cursor-pointer flex items-center gap-2 hover:text-sky-600 active:scale-95 transition bg-sky-50 px-5 py-2 rounded-full border border-sky-100 shadow-sm" onclick="resetToHome()">
                    <i class="fas fa-times-circle"></i> Bersihkan pencarian
                </div>
            </div>

            <!-- Home Featured Player -->
            <div id="homeFeatured" class="w-full flex items-center gap-[50px] mb-[60px]">
                <img id="hmCover" src="" class="w-[320px] h-[320px] rounded-[24px] border-[8px] border-[#3d6b4d] object-cover bg-[#eef2eb] shadow-xl shrink-0" alt="Cover" onerror="this.src='https://placehold.co/400x400/eef2eb/3d6b4d?text=Cover'">
                <div class="flex-1 flex flex-col justify-center">
                    <h1 id="hmTitle" class="font-['Gelasio'] font-bold text-[46px] leading-[1.2] text-[#1a1a1a] mb-[20px]">Memuat...</h1>
                    <p id="hmDesc" class="text-[24px] text-slate-500">Mohon tunggu...</p>
                    
                    <div class="w-full flex items-center gap-[20px] mt-[40px] mb-[40px]">
                        <span id="hmCur" class="font-bold text-[26px] text-slate-800 w-[80px] text-center">00:00</span>
                        <div class="flex-1 h-[14px] bg-slate-300 rounded-[10px] relative cursor-pointer" onclick="seekAudio(event)">
                            <div id="hmFill" class="absolute left-0 top-0 bottom-0 bg-[#3730a3] rounded-[10px] w-0 transition-all duration-100 pointer-events-none">
                                <div class="absolute right-[-15px] top-[-6px] w-[30px] h-[26px] bg-[#3730a3] rounded-full border-[3px] border-white shadow-md"></div>
                            </div>
                        </div>
                        <span id="hmTot" class="font-bold text-[26px] text-slate-800 w-[80px] text-center">00:00</span>
                    </div>

                    <div class="w-full flex justify-center items-center gap-[60px]">
                        <i class="fas fa-step-backward text-[60px] cursor-pointer text-slate-800 active:scale-95" onclick="prevTrack()"></i>
                        <i id="hmPlayBtn" class="fas fa-play text-[90px] cursor-pointer text-slate-800 active:scale-95" onclick="togglePlay()"></i>
                        <i class="fas fa-step-forward text-[60px] cursor-pointer text-slate-800 active:scale-95" onclick="nextTrack()"></i>
                    </div>
                </div>
            </div>

            <div class="w-full bg-white rounded-[40px] p-[50px] shadow-sm">
                <div id="gridContainer" class="grid grid-cols-2 gap-[30px]"></div>
                
                <div id="emptyContainer" class="hidden flex-col items-center justify-center min-h-[500px] text-center gap-[40px]">
                    <div class="font-['Gelasio'] font-bold text-[46px] text-slate-800">Tidak Ditemukan</div>
                    <div class="w-[220px] h-[220px] rounded-full bg-slate-100 flex items-center justify-center text-slate-300 text-[110px] shadow-inner">
                        <i class="fas fa-search-minus"></i>
                    </div>
                    <p class="font-['Lato'] text-[28px] text-slate-400 px-10 leading-relaxed">
                        Data rekaman audio untuk pencarian tersebut<br>tidak ditemukan dalam sistem.
                    </p>
                </div>
            </div>
        </div>

        <!-- DETAIL VIEW -->
        <div id="viewDetail" class="hidden w-full max-w-[800px] flex-col items-center">
            
            <div class="w-full flex justify-center items-center mb-[25px] relative z-20 px-4">
                <div class="font-['Lato'] text-[26px] font-bold text-sky-500 cursor-pointer flex items-center gap-3 hover:text-sky-600 active:scale-95 transition bg-white px-8 py-3 rounded-full shadow-sm" onclick="goBack()">
                    <i class="fas fa-chevron-left"></i> Kembali ke daftar audio
                </div>
            </div>

            <div class="w-full bg-white rounded-[40px] p-[60px] shadow-xl flex flex-col gap-[40px] mb-[80px]">
                
                <div class="flex items-start gap-[50px]">
                    <div class="w-[240px] h-[340px] shrink-0 rounded-[12px] overflow-hidden border-[4px] border-slate-100 shadow-lg bg-slate-50 flex items-center justify-center">
                        <img id="dtlCover" src="" class="w-full h-full object-cover" onerror="this.src='https://placehold.co/400x600/f1f5f9/94a3b8?text=Cover'">
                    </div>
                    <div class="flex-1 flex flex-col pt-4">
                        <h1 id="dtlTitle" class="font-['Gelasio'] font-bold text-[36px] leading-tight text-slate-900 mb-4 border-b-2 border-slate-200 pb-4">Judul</h1>
                        
                        <div class="mt-2 flex flex-col gap-2">
                            <span class="font-['Inter'] text-[18px] text-slate-500 font-semibold">Status Rekaman:</span>
                            <div class="flex items-center gap-3">
                                <span class="bg-green-100 text-green-700 font-bold px-4 py-2 rounded-lg text-[22px]">Tersedia & Aktif</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="w-full bg-slate-50 rounded-[30px] border-2 border-slate-100 p-[30px] flex flex-col gap-[30px]">
                    <div class="flex justify-between items-center text-[24px] font-bold text-slate-800">
                        <span id="dtlCur">00:00</span>
                        <div class="flex-1 mx-[30px] h-[14px] bg-slate-300 rounded-[10px] relative cursor-pointer" onclick="seekAudio(event)">
                            <div id="dtlFill" class="absolute left-0 top-0 bottom-0 bg-[#3730a3] rounded-[10px] w-0 pointer-events-none"></div>
                        </div>
                        <span id="dtlTot">00:00</span>
                    </div>
                    <div class="flex justify-center items-center gap-[60px]">
                        <i class="fas fa-undo text-[45px] text-slate-400 cursor-pointer active:scale-95" onclick="jump(-10)"></i>
                        <i id="dtlPlayBtn" class="fas fa-play text-[80px] text-indigo-800 cursor-pointer active:scale-95" onclick="togglePlay()"></i>
                        <i class="fas fa-redo text-[45px] text-slate-400 cursor-pointer active:scale-95" onclick="jump(10)"></i>
                    </div>
                </div>

                <div class="w-full">
                    <h2 class="font-['Gelasio'] font-bold text-[30px] text-slate-900 mb-6 flex items-center gap-4">
                        <i class="fas fa-info-circle text-sky-500"></i> Informasi Detail
                    </h2>
                    
                    <div class="bg-slate-50 rounded-[20px] p-[40px] border border-slate-200">
                        <table class="w-full text-left font-['Inter'] text-[24px] text-slate-700">
                            <tbody>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Judul Utama</td>
                                    <td class="py-5 font-bold align-top text-slate-900" id="dtlTitleTable">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Pengisi / Kreator</td>
                                    <td class="py-5 align-top" id="dtlAuthor">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">No. Panggil</td>
                                    <td class="py-5 font-bold text-sky-700 align-top" id="dtlCall">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Penerbitan</td>
                                    <td class="py-5 align-top" id="dtlPub">-</td>
                                </tr>
                                <tr class="border-b border-slate-200">
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Format / Fisik</td>
                                    <td class="py-5 align-top" id="dtlPhysical">-</td>
                                </tr>
                                <tr>
                                    <td class="py-5 font-semibold text-slate-500 w-[35%] align-top">Kategori / Subjek</td>
                                    <td class="py-5 align-top" id="dtlCat">-</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- MODAL FILTER -->
    <div id="audFilterOverlay" class="aud-filter-overlay" onclick="toggleAudFilter()">
        <div class="aud-filter-card" onclick="event.stopPropagation()">
            <div class="aud-filter-close" onclick="toggleAudFilter()"><i class="fas fa-times"></i></div>
            <h2 class="aud-filter-title">Filter Kategori</h2>
            <form onsubmit="applyFilterSearch(event)">
                <div class="aud-filter-grid">
                    <label class="aud-filter-item"><input type="checkbox" id="chkJudul" value="judul" checked><div class="aud-checkbox-ui"></div><span class="aud-label-text">Judul</span></label>
                    <label class="aud-filter-item"><input type="checkbox" id="chkInstansi" value="instansi"><div class="aud-checkbox-ui"></div><span class="aud-label-text">Label /<br>instansi</span></label>
                    <label class="aud-filter-item"><input type="checkbox" id="chkIsbn" value="isbn"><div class="aud-checkbox-ui"></div><span class="aud-label-text">ISBN/Kategori</span></label>
                    <label class="aud-filter-item"><input type="checkbox" id="chkPengisi" value="pengisi"><div class="aud-checkbox-ui"></div><span class="aud-label-text">Pengisi<br>suara</span></label>
                </div>
                <button type="submit" class="aud-btn-apply">Terapkan Filter</button>
            </form>
        </div>
    </div>

</div>

<script>
    const basePath = "${basePath!"/images/frontoffice"}";

    const dbTracks = [
        <#if audioList?? && audioList?has_content>
            <#list audioList as audio>
            {
                id: ${audio.id?c},
                title: "${(audio.title!'Tanpa Judul')?js_string}",
                desc: "${(audio.description!'Rekaman audio perpustakaan')?js_string}",
                callNum: "${(audio.callNumber!'000')?js_string}",
                category: "${(audio.subject!'Audio')?js_string}",
                author: "${(audio.responsibility!'Anonim')?js_string}",
                publisher: "${(audio.publisher!'-')?js_string}",
                mediaType: "${(audio.mediaType!'Audio')?js_string}",
                audioFormat: "${(audio.audioFormat!'MP3')?js_string}",
                
                <#if (audio.title?lower_case)?contains("peminjaman")>
                    fileUrl: "/audio/meminjam.mp3",
                <#elseif (audio.title?lower_case)?contains("pendaftaran")>
                    fileUrl: "/audio/daftaranggota.mp3",
                <#elseif (audio.title?lower_case)?contains("lumbung")>
                    fileUrl: "/audio/marsperpus.mp3",
                <#else>
                    fileUrl: "/audio/indonesiaraya.mp3",
                </#if>

                <#-- DIPERBAIKI: Menambahkan prefiks /admin agar sesuai dengan AudioController.java -->
                img: "/admin/audio/image/${audio.id?c}"
            }<#if audio?has_next>,</#if>
            </#list>
        <#else>
            { id: 0, title: "Mars Perpustakaan Nasional", desc: "Lagu resmi tanpa vokal.", callNum: "782.421", category: "Musik", author: "Pemerintah RI", publisher: "Perpusnas, 2020", mediaType: "Audio", audioFormat: "MP3", fileUrl: "/audio/marsperpus.mp3", img: "https://placehold.co/400x400/eef2eb/3d6b4d?text=Mars" }
        </#if>
    ];

    if (!dbTracks || dbTracks.length === 0) {
        dbTracks.push({
            id: 0, title: "Mars Perpustakaan Nasional", desc: "Lagu resmi tanpa vokal.", callNum: "782.421", category: "Musik", author: "Pemerintah RI", publisher: "Perpusnas, 2020", mediaType: "Audio", audioFormat: "MP3", fileUrl: "/audio/marsperpus.mp3", img: "https://placehold.co/400x400/eef2eb/3d6b4d?text=Mars"
        });
    }

<#noparse>
    let currentTracks = [...dbTracks];
    let activeIdx = dbTracks.length > 0 ? dbTracks[0].id : 0;
    let currentView = 'home';
    const audioElement = document.getElementById('audioEngine');

    window.stopAudioFragment = function() {
        audioElement.pause();
        audioElement.currentTime = 0;
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
            vBrowse.classList.remove('hidden'); vBrowse.classList.add('flex');
            vDetail.classList.add('hidden'); vDetail.classList.remove('flex');
            
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
            vBrowse.classList.add('hidden'); vBrowse.classList.remove('flex');
            vDetail.classList.remove('hidden'); vDetail.classList.add('flex');
            renderDetail();
        }
        syncUI();
    }

    function handleSearch(e) {
        e.preventDefault();
        const query = document.getElementById('searchInput').value.trim().toLowerCase();
        if(query === '' || query === 'koleksi audio & podcast') { resetToHome(); return; }
        
        document.getElementById('searchTitle').innerText = 'Hasil pencarian "' + document.getElementById('searchInput').value + '"';
        
        const isJudul = document.getElementById('chkJudul').checked;
        const isInstansi = document.getElementById('chkInstansi').checked;
        const isIsbn = document.getElementById('chkIsbn').checked;
        const isPengisi = document.getElementById('chkPengisi').checked;

        currentTracks = dbTracks.filter(t => {
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
        audioElement.pause();
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
            let isSpin = (t.id === activeIdx && !audioElement.paused) ? "aud-spin" : "";
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
        if(activeIdx !== trackId) { 
            activeIdx = trackId; 
            loadTrackSource(true);
        } else {
            loadTrackSource(false);
        }
        navigateTo('detail');
    }

    function loadTrackSource(forceReset = false) {
        const t = dbTracks.find(x => x.id === activeIdx) || dbTracks[0];
        if(t) {
            if(audioElement.src !== window.location.origin + t.fileUrl || forceReset) {
                audioElement.pause();
                audioElement.src = t.fileUrl;
                audioElement.load();
                audioElement.currentTime = 0;
            }
        }
    }

    function renderDetail() {
        const t = dbTracks.find(x => x.id === activeIdx) || dbTracks[0];
        if(!t) return;
        
        document.getElementById('dtlTitle').innerText = t.title;
        document.getElementById('dtlTitleTable').innerText = t.title;
        document.getElementById('dtlCall').innerText = t.callNum;
        document.getElementById('dtlCat').innerText = t.category;
        document.getElementById('dtlAuthor').innerText = t.author;
        document.getElementById('dtlPub').innerText = t.publisher;
        document.getElementById('dtlPhysical').innerText = t.mediaType + " (" + t.audioFormat + ")";
        document.getElementById('dtlCover').src = t.img;
        
        syncUI();
    }

    function syncUI() {
        const t = dbTracks.find(x => x.id === activeIdx) || dbTracks[0];
        if(t) {
            document.getElementById('hmTitle').innerText = t.title;
            document.getElementById('hmDesc').innerText = t.desc ? t.desc.substring(0, 40) + '...' : '';
            document.getElementById('hmCover').src = t.img;
        }
        
        if(!isNaN(audioElement.duration) && audioElement.duration > 0) {
            let pct = (audioElement.currentTime / audioElement.duration) * 100;
            document.getElementById('hmFill').style.width = pct + "%";
            document.getElementById('dtlFill').style.width = pct + "%";
            document.getElementById('hmCur').innerText = fmt(audioElement.currentTime);
            document.getElementById('dtlCur').innerText = fmt(audioElement.currentTime);
            document.getElementById('hmTot').innerText = fmt(audioElement.duration);
            document.getElementById('dtlTot').innerText = fmt(audioElement.duration);
        }

        const isCurrentlyPlaying = !audioElement.paused;
        const playIco = isCurrentlyPlaying ? 'fa-pause' : 'fa-play';
        document.getElementById('hmPlayBtn').className = "fas " + playIco + " text-[90px] cursor-pointer text-slate-800 active:scale-95 transition";
        document.getElementById('dtlPlayBtn').className = "fas " + playIco + " text-[80px] text-indigo-800 cursor-pointer active:scale-95 transition";
        
        renderGrid();
    }

    function togglePlay() {
        loadTrackSource(false);
        if(audioElement.paused) {
            audioElement.play().then(() => {
                syncUI();
            }).catch(e => console.log("Audio play error:", e));
        } else {
            audioElement.pause();
            syncUI();
        }
    }

    audioElement.addEventListener('timeupdate', syncUI);
    audioElement.addEventListener('play', syncUI);
    audioElement.addEventListener('pause', syncUI);
    audioElement.addEventListener('ended', () => { nextTrack(); });

    function nextTrack() { 
        let idx = dbTracks.findIndex(x => x.id === activeIdx);
        idx = (idx + 1) % dbTracks.length;
        activeIdx = dbTracks[idx].id;
        loadTrackSource(true);
        audioElement.play().catch(e => {});
        syncUI(); 
        if(currentView === 'detail') renderDetail(); 
    }
    
    function prevTrack() { 
        let idx = dbTracks.findIndex(x => x.id === activeIdx);
        idx = (idx - 1 + dbTracks.length) % dbTracks.length;
        activeIdx = dbTracks[idx].id;
        loadTrackSource(true);
        audioElement.play().catch(e => {});
        syncUI(); 
        if(currentView === 'detail') renderDetail(); 
    }
    
    function jump(s) {
        audioElement.currentTime += s;
        syncUI();
    }

    function seekAudio(e) {
        const rect = e.currentTarget.getBoundingClientRect();
        let pos = (e.clientX - rect.left) / rect.width;
        if(!isNaN(audioElement.duration)) {
            audioElement.currentTime = pos * audioElement.duration;
        }
        syncUI();
    }

    function fmt(s) { 
        if(isNaN(s)) return "00:00";
        let m = Math.floor(s / 60), sc = Math.floor(s % 60); 
        return (m < 10 ? "0" + m : m) + ":" + (sc < 10 ? "0" + sc : sc); 
    }

    function toggleAudFilter() {
        const m = document.getElementById('audFilterOverlay');
        m.style.display = (m.style.display === 'flex') ? 'none' : 'flex';
    }

    function applyFilterSearch(e) {
        e.preventDefault();
        toggleAudFilter();
        handleSearch(e);
    }

    setTimeout(() => { 
        resetToHome(); 
        loadTrackSource(true);
    }, 150);
</#noparse>
</script>