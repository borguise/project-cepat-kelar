<#-- =======================================================
     ARTICLES.FTL - KIOSK SPA SINGLE FILE (BERITA & DETAIL)
     ======================================================= -->

<style>
    .art-scroll-area::-webkit-scrollbar { display: none; }
    .art-scroll-area { scrollbar-width: none; overflow-y: auto; height: 100%; width: 100%; padding-bottom: 100px; position: relative; z-index: 10; }
    
    .art-batik-layer {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
        background-size: 520px; opacity: 0.12; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    @import url('https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&display=swap');
    
    .fg-title { font-family: 'Gelasio', serif; color: #3B5998; font-size: 42px; font-weight: bold; text-align: center; margin-bottom: 30px; line-height: 1.2; }
    .fg-image { width: 100%; height: 400px; object-fit: cover; border-radius: 16px; margin-bottom: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    .fg-content { font-family: 'Lato', sans-serif; color: #334155; font-size: 20px; line-height: 1.8; text-align: justify; margin-bottom: 50px; }
    .fg-content p { margin-bottom: 20px; }

    .fg-comment-box { background-color: #E2E8F0; border-radius: 24px; padding: 40px; margin-bottom: 40px; display: flex; flex-direction: column; gap: 20px; }
    .fg-input { width: 100%; padding: 18px 24px; border-radius: 12px; border: none; font-family: 'Lato', sans-serif; font-size: 16px; color: #333; outline: none; box-sizing: border-box; }
    .fg-textarea-wrapper { position: relative; width: 100%; }
    .fg-textarea { width: 100%; padding: 18px 24px; border-radius: 12px; border: none; height: 120px; resize: none; font-family: 'Lato', sans-serif; font-size: 16px; color: #333; outline: none; box-sizing: border-box; }
    .fg-submit-btn { position: absolute; bottom: 15px; right: 20px; background: transparent; border: none; font-size: 24px; color: #3B5998; cursor: pointer; }
    
    .fg-comment-list { display: flex; flex-direction: column; gap: 20px; margin-top: 20px; }
    .fg-comment-item { display: flex; gap: 20px; align-items: flex-start; }
    .fg-avatar { width: 50px; height: 50px; border-radius: 50%; background-color: #3B5998; color: white; display: flex; justify-content: center; align-items: center; font-size: 20px; flex-shrink: 0; }
    .fg-comment-text-area { display: flex; flex-direction: column; gap: 4px; padding-top: 4px; }
    .fg-comment-name { font-family: 'Lato', sans-serif; font-size: 16px; font-weight: bold; color: #3B5998; }
    .fg-comment-isi { font-family: 'Lato', sans-serif; font-size: 16px; color: #475569; line-height: 1.5; }
</style>

<div class="w-full h-full bg-[#f7f0cb] relative overflow-hidden">
    
    <div class="art-batik-layer"></div>

    <div class="art-scroll-area flex flex-col items-center">
        
        <div class="w-full max-w-[800px] px-4 mt-6">
            <#if commentSuccess??>
                <div class="bg-green-100 border border-green-400 text-green-700 px-6 py-4 rounded-xl relative mb-4 font-['Lato']" role="alert">
                    <span class="block sm:inline">${commentSuccess}</span>
                </div>
            </#if>
            <#if commentError??>
                <div class="bg-red-100 border border-red-400 text-red-700 px-6 py-4 rounded-xl relative mb-4 font-['Lato']" role="alert">
                    <span class="block sm:inline">${commentError}</span>
                </div>
            </#if>
        </div>

        <!-- 1. BROWSE VIEW (DAFTAR GRID ARTIKEL) -->
        <div id="artViewBrowse" class="w-full max-w-[800px] flex flex-col items-center">
            <div class="w-full mt-[60px]"></div>
            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-sm min-h-[600px] mb-10">
                <div id="artGridContainer" class="grid grid-cols-3 gap-[50px_30px]">
                    <!-- Konten diinjeksi oleh JavaScript dari artDbArticles -->
                </div>
            </div>
        </div>

        <!-- 2. DETAIL VIEW -->
        <div id="artViewDetail" class="hidden w-full max-w-[800px] flex-col items-center mt-[100px]">
            <div class="w-full flex justify-center mb-[25px] relative z-20">
                <div class="font-['Lato'] text-[24px] font-bold text-sky-500 cursor-pointer flex items-center gap-3 bg-white px-6 py-3 rounded-full shadow-sm hover:text-sky-600 transition" onclick="artGoBack()">
                    <i class="fas fa-chevron-left"></i> Kembali ke daftar berita
                </div>
            </div>

            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-xl flex flex-col mb-[80px]">
                <div class="fg-wrapper">
                    
                    <h1 id="artDtlTitle" class="fg-title">Judul Berita</h1>
                    <img id="artDtlImg" src="" class="fg-image" alt="Gambar Berita">

                    <div id="artDtlContent" class="fg-content">
                        <!-- Isi teks paragraf -->
                    </div>

                    <form action="/comment/submit" method="POST" class="fg-comment-box">
                        <#if _csrf??>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </#if>
                        <input type="hidden" id="artDtlIdField" name="articleId" value="">
                        <input type="hidden" id="artDtlRedirectField" name="redirectUrl" value="">
                        
                        <input type="text" name="name" placeholder="Nama Lengkap" class="fg-input" required>
                        <input type="email" name="email" placeholder="Email" class="fg-input" required>
                        
                        <div class="fg-textarea-wrapper">
                            <textarea name="comment" placeholder="Tuliskan Komentar anda disini" class="fg-textarea" required></textarea>
                            <button type="submit" class="fg-submit-btn">
                                <i class="fa-regular fa-paper-plane"></i>
                            </button>
                        </div>
                    </form>

                    <div class="fg-comment-list">
                        <div class="fg-comment-item">
                            <div class="fg-avatar"><i class="fa-solid fa-user"></i></div>
                            <div class="fg-comment-text-area">
                                <div class="fg-comment-name">Admin Graha Pusat Literasi</div>
                                <div class="fg-comment-isi">Belum ada komentar pada artikel ini. Jadilah yang pertama memberikan pendapat Anda!</div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

<script>
    // Data artikel dari database backend
    const artDbArticles = [
    <#if articlesMap?? && articlesMap?has_content>
        <#list articlesMap as a>
        { 
            id: ${a.id}, 
            title: "${(a.title!'')?js_string}", 
            content: "${(a.content!'')?js_string}", 
            img: "/admin/articles/image/${a.id}",
            comments: [
                <#if a.comments??>
                    <#list a.comments as c>
                    {
                        sender: "${(c.sender!'Anonim')?js_string}",
                        content: "${(c.content!'')?js_string}",
                        date: "${(c.date!'')?js_string}"
                    }<#if c?has_next>,</#if>
                    </#list>
                </#if>
            ]
        }<#if a?has_next>,</#if>
        </#list>
    <#elseif articles?? && articles?has_content>
        <#list articles as a>
        { 
            id: ${a.id}, 
            title: "${(a.title!'')?js_string}", 
            content: "${(a.content!'')?js_string}", 
            img: "/admin/articles/image/${a.id}",
            comments: [
                <#if a.comments??>
                    <#list a.comments as c>
                    {
                        sender: "${(c.sender!'Anonim')?js_string}",
                        content: "${(c.content!'')?js_string}",
                        date: "${(c.date!'')?js_string}"
                    }<#if c?has_next>,</#if>
                    </#list>
                </#if>
            ]
        }<#if a?has_next>,</#if>
        </#list>
    <#else>
        { 
            id: 0, 
            title: "Belum Ada Artikel Dipublikasikan", 
            content: "<p>Silakan buat dan publikasikan artikel melalui halaman admin terlebih dahulu.</p>", 
            img: "https://placehold.co/400x400?text=Kosong",
            comments: []
        }
    </#if>
    ];

<#noparse>
    function artNavigateTo(view) {
        const browse = document.getElementById('artViewBrowse');
        const detail = document.getElementById('artViewDetail');
        if (!browse || !detail) return;

        browse.classList.toggle('hidden', view !== 'home');
        browse.classList.toggle('flex', view === 'home');
        detail.classList.toggle('hidden', view !== 'detail');
        detail.classList.toggle('flex', view === 'detail');
        
        if (view === 'home') {
            artRenderGrid();
        }
    }

    function artRenderGrid() {
        const grid = document.getElementById('artGridContainer');
        if (!grid) return;

        grid.innerHTML = artDbArticles.map((item, index) => {
            if (index === 0) {
                return `
                    <div onclick="artOpenDetail(${item.id})" class="col-span-3 block w-full bg-white/95 rounded-[30px] p-6 mb-4 shadow-md cursor-pointer transition-all duration-300 hover:-translate-y-2 text-center">
                        <img src="${item.img}" class="w-full h-[380px] object-cover rounded-[20px] mb-6 shadow-sm bg-slate-100" onerror="this.src='https://placehold.co/800x400?text=Artikel'">
                        <h2 class="font-['Gelasio'] text-[38px] font-bold text-slate-800 mb-3 leading-tight">${item.title}</h2>
                        <p class="font-['Lato'] text-[22px] text-slate-500">Klik untuk membaca cerita selengkapnya...</p>
                    </div>
                `;
            }
            return `
                <div onclick="artOpenDetail(${item.id})" class="flex flex-col items-center text-center cursor-pointer group transition-all duration-300 hover:-translate-y-2">
                    <div class="w-full aspect-square rounded-[20px] mb-4 overflow-hidden bg-slate-100 shadow-sm group-hover:shadow-md border border-white/60">
                        <img src="${item.img}" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" onerror="this.src='https://placehold.co/400x400?text=Artikel'">
                    </div>
                    <span class="font-['Lato'] text-[20px] font-bold text-slate-800 group-hover:text-[#3B5998] transition-colors leading-snug px-1">${item.title}</span>
                </div>
            `;
        }).join('');
    }

    function artOpenDetail(id) {
        // Menggunakan konversi String agar pencocokan ID aman dari perbedaan tipe data (Number vs String)
        const target = artDbArticles.find(x => String(x.id) === String(id));
        if (!target) return;

        const titleEl = document.getElementById('artDtlTitle');
        const imgEl = document.getElementById('artDtlImg');
        const contentEl = document.getElementById('artDtlContent');
        const idField = document.getElementById('artDtlIdField');
        const redirectField = document.getElementById('artDtlRedirectField');

        if (titleEl) titleEl.innerText = target.title;
        if (imgEl) imgEl.src = target.img;
        if (contentEl) contentEl.innerHTML = target.content;
        if (idField) idField.value = target.id;

        // Menggunakan jalur URL aktif saat ini (misal: /home) secara dinamis agar tetap di halaman asal
        if (redirectField) {
            redirectField.value = window.location.pathname + "?openId=" + target.id;
        }

        // RENDER KOMENTAR MENGGUNAKAN STRING CONCATENATION
        const commentListContainer = document.querySelector('.fg-comment-list');
        if (commentListContainer) {
            if (target.comments && target.comments.length > 0) {
                let htmlContent = '';
                for (let i = 0; i < target.comments.length; i++) {
                    let c = target.comments[i];
                    htmlContent += '<div class="fg-comment-item">' +
                        '<div class="fg-avatar"><i class="fa-solid fa-user"></i></div>' +
                        '<div class="fg-comment-text-area">' +
                            '<div class="fg-comment-name">' + c.sender + ' <span class="text-xs font-normal text-slate-400 ml-2">' + c.date + '</span></div>' +
                            '<div class="fg-comment-isi">' + c.content + '</div>' +
                        '</div>' +
                    '</div>';
                }
                commentListContainer.innerHTML = htmlContent;
            } else {
                commentListContainer.innerHTML = '<div class="fg-comment-item">' +
                    '<div class="fg-avatar"><i class="fa-solid fa-user"></i></div>' +
                    '<div class="fg-comment-text-area">' +
                        '<div class="fg-comment-name">Admin Graha Pusat Literasi</div>' +
                        '<div class="fg-comment-isi">Belum ada komentar pada artikel ini. Jadilah yang pertama memberikan pendapat Anda!</div>' +
                    '</div>' +
                '</div>';
            }
        }

        artNavigateTo('detail');
    }

    function artGoBack() {
        window.history.replaceState({}, document.title, window.location.pathname);
        artNavigateTo('home');
    }

    // Inisialisasi instan untuk mendukung lingkungan SPA / Kiosk
    function initArticleModule() {
        const urlParams = new URLSearchParams(window.location.search);
        const openId = urlParams.get('openId');
        if (openId) {
            artOpenDetail(openId);
        } else {
            artNavigateTo('home');
        }

        // Interseptor AJAX form komentar agar langsung reload dengan openId di path asal
        const commentForm = document.querySelector('.fg-comment-box');
        if (commentForm && !commentForm.dataset.initialized) {
            commentForm.dataset.initialized = "true";
            commentForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const formData = new FormData(commentForm);
                const articleId = document.getElementById('artDtlIdField').value;

                fetch(commentForm.action, {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    window.location.href = window.location.pathname + "?openId=" + articleId;
                })
                .catch(error => {
                    console.error('Gagal mengirim komentar:', error);
                    commentForm.submit();
                });
            });
        }
    }

    // Eksekusi langsung tanpa menunggu DOMContentLoaded yang terkadang terlewat di SPA
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initArticleModule);
    } else {
        initArticleModule();
    }
</#noparse>
</script>