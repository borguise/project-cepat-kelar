<#-- =======================================================
     ARTICLES-DETAILS.FTL - TRUE FRAGMENT (KOMPATIBEL HOME.FTL)
     Murni komponen visual tanpa bentrokan scale/skrip parent.
     ======================================================= -->

<#if !article??>
    <#-- Fallback Dummy Data -->
    <#assign article = {
        "id": 1,
        "title": "Memori Milik Kita",
        "content": "<p>Perpustakaan bukan sekadar ruang penyimpanan, melainkan tempat di mana ingatan bersama dirawat dan diberi makna. Di Graha Pusat Literasi, ingatan itu hidup melalui koleksi konten lokal—rekaman tentang sejarah, budaya, dan identitas Magetan yang tumbuh bersama masyarakatnya.</p><br><p>Beragam jejak masa lalu tersimpan dan dapat diperjelajahi di sini. Naskah-naskah lama, artefak bersejarah, hingga karya para penulis dan budayawan daerah hadir sebagai cerita yang saling terhubung.</p><br><p>Untuk membantu perjalanan itu, Graha Pusat Literasi menghadirkan katalog sebagai pemandu awal yang tertata rapi. Melalui katalog, pengunjung dapat menelusuri koleksi secara mandiri, bergerak dari satu informasi ke informasi lain dengan tenang, tanpa merasa terburu-buru atau kebingungan.</p>",
        "img": "/assets/images/placeholder-hero.jpg"
    }>
</#if>

<style>
    /* ========================================================
       KODE CSS MURNI UNTUK KOMPONEN ARTIKEL
       ======================================================== */
    /* Kertas Krem Cair (Mengikuti 100% wadah parent di home.ftl) */
    .detail-kertas-krem {
        width: 100%; 
        min-height: 100%; 
        background-color: #FAF6ED; 
        position: relative; 
        box-sizing: border-box;
        overflow: hidden; /* Mencegah elemen keluar batas */
    }

    /* Latar Batik */
    .detail-batik-bg {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/assets/images/batikspring.png"}'); 
        background-size: 500px; opacity: 0.15; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1; 
    }

    .detail-content-wrapper {
        position: relative; z-index: 10;
        padding: 0 70px 120px 70px; display: flex; flex-direction: column;
    }

    /* Header & Navigasi Natural */
    .detail-header-group {
        width: 100%; text-align: center; margin-top: 60px; margin-bottom: 50px;
    }

    .detail-back-link-center {
        display: inline-flex; align-items: center; justify-content: center; gap: 10px;
        color: #3B5998; font-family: 'Lato', sans-serif; font-size: 20px; font-weight: bold;
        text-decoration: none; margin-bottom: 24px; transition: color 0.2s ease-in-out;
    }
    .detail-back-link-center:hover { color: #ef4444; }

    .detail-article-title-main {
        font-family: 'Gelasio', serif; color: #3B5998;
        font-size: 46px; font-weight: bold; line-height: 1.3;
        max-width: 90%; margin: 0 auto;
    }

    /* Gambar & Teks */
    .detail-main-img { 
        width: 100%; height: 480px; object-fit: cover; 
        border-radius: 20px; margin-bottom: 60px; 
        background-color: #e2e8f0; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    }
    
    .detail-body-text { 
        font-family: 'Gelasio', serif; color: #3B5998; 
        font-size: 24px; font-weight: bold; line-height: 1.8; 
        text-align: center; width: 100%; margin-bottom: 60px;
    }
    .detail-body-text p { margin-bottom: 28px; margin-top: 0; }

    /* Seksi Komentar */
    .detail-comment-section {
        width: 100%; background-color: #DCD9D1; border-radius: 30px; 
        padding: 50px; display: flex; flex-direction: column; gap: 24px;
    }

    .detail-input-field {
        width: 100%; background: white; border-radius: 16px;
        padding: 20px 24px; font-family: 'Lato', sans-serif; font-size: 20px;
        border: none; outline: none; color: #333;
    }
    .detail-input-field::placeholder, .detail-textarea-field::placeholder { color: #4A4A4A; font-weight: bold; }

    .detail-textarea-field {
        width: 100%; height: 160px; background: white; border-radius: 16px;
        padding: 24px; font-family: 'Lato', sans-serif; font-size: 20px;
        border: none; resize: none; outline: none; color: #333;
    }

    /* Daftar Komentar */
    .detail-comment-list-wrapper {
        margin-top: 60px; width: 100%;
        border-top: 2px solid rgba(0,0,0,0.1); padding-top: 50px;
    }
    
    .detail-comment-item { 
        display: flex; align-items: flex-start; gap: 20px;
        background: #ffffff; padding: 24px 30px; border-radius: 24px;
        margin-bottom: 24px; box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        border: 1px solid rgba(0,0,0,0.05);
    }
    
    .detail-avatar-box {
        font-size: 20px; color: white; background: #3B5998; 
        display: flex; align-items: center; justify-content: center;
        width: 55px; height: 55px; border-radius: 50%; flex-shrink: 0;
    }
    
    .detail-comment-content { display: flex; flex-direction: column; gap: 6px; }
    .detail-user-name { font-family: 'Lato', sans-serif; font-size: 18px; color: #3B5998; font-weight: bold; }
    .detail-user-text { font-family: 'Gelasio', serif; font-size: 22px; color: #334155; line-height: 1.5; font-weight: 500; }
</style>

<div class="detail-kertas-krem" id="article-detail-container">
    
    <div class="detail-batik-bg"></div>

    <div class="detail-content-wrapper">
        
        <div class="detail-header-group">
            <a href="javascript:void(0)" onclick="closeDetailOverlay()" class="detail-back-link-center">
                <i class="fas fa-arrow-left"></i> Kembali ke daftar berita
            </a>
            <h1 class="detail-article-title-main">${(article.title)!"Judul Artikel"}</h1>
        </div>
        
        <#if article.img?? && article.img?has_content>
            <img src="${article.img}" class="detail-main-img" alt="${article.title!''}">
        <#elseif (article.id > 0)>
            <img src="/admin/articles/image/${article.id?c}" class="detail-main-img" onerror="this.style.display='none'">
        <#else>
            <div class="detail-main-img flex items-center justify-center">
                <i class="fas fa-image text-8xl text-slate-400"></i>
            </div>
        </#if>

        <div class="detail-body-text">
            ${(article.content)!"Isi artikel belum tersedia."?no_esc}
        </div>

        <div class="detail-comment-section">
            <form action="#" method="POST" style="display: flex; flex-direction: column; gap: 24px;" onsubmit="alert('Komentar Aktif setelah backend tersambung.'); return false;">
                <input type="hidden" name="articleId" value="${(article.id)!''}"/>
                <input type="email" name="email" placeholder="Email" class="detail-input-field" required>
                <input type="password" name="password" placeholder="Password" class="detail-input-field">
                
                <div style="position: relative;">
                    <textarea name="comment" placeholder="Tuliskan Komentar anda disini" class="detail-textarea-field" required></textarea>
                    <button type="submit" style="position: absolute; bottom: 24px; right: 24px; background: transparent; border: none; font-size: 32px; color: #1a1a1a; cursor: pointer; transition: transform 0.2s;">
                        <i class="fa-regular fa-paper-plane hover:text-[#3B5998]"></i>
                    </button>
                </div>
            </form>
        </div>

        <div class="detail-comment-list-wrapper">
            <#if comments?? && comments?size gt 0>
                <#list comments as c>
                    <div class="detail-comment-item">
                        <div class="detail-avatar-box">
                            <#if c.avatar??><img src="${c.avatar}" class="rounded-full w-full h-full"><#else><i class="fas fa-user"></i></#if>
                        </div>
                        <div class="detail-comment-content">
                            <div class="detail-user-name">${c.userName}</div>
                            <div class="detail-user-text">${c.text}</div>
                        </div>
                    </div>
                </#list>
            <#else>
                <div class="detail-comment-item">
                    <div class="detail-avatar-box"><i class="fas fa-user"></i></div>
                    <div class="detail-comment-content">
                        <div class="detail-user-name">Nama</div>
                        <div class="detail-user-text">Isi komentar Anda akan tampil di sini.</div>
                    </div>
                </div>
            </#if>
        </div>

    </div>
</div>

<script>
    // FUNGSI NAVIGASI: Kembali ke daftar berita dengan aman
    function closeDetailOverlay() {
        // Logika ini bergantung pada bagaimana backend Anda merender halaman.
        // Jika detail dipanggil via AJAX, cukup sembunyikan wadah detailnya:
        const detailContainer = document.getElementById('article-detail-container');
        if(detailContainer) {
            // Opsi 1: Sembunyikan elemen ini jika di-load dalam satu halaman (SPA)
            detailContainer.style.display = 'none';
        } else {
            // Opsi 2: Jika terpaksa harus pindah URL, gunakan history back
            window.history.back();
        }
    }
</script>