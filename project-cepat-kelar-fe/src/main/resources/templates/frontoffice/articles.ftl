<#-- =======================================================
     DATA PREPARATION (MENDUKUNG DATABASE)
     ======================================================= -->
<#assign articleData = articles![]>
<#if articleData?size == 0>
    <#-- Fallback Dummy Data jika database kosong -->
    <#assign articleData = [
        { "id": 1, "title": "Memori Milik Kita", "content": "Sebuah perpustakaan modern tidak hanya menyimpan buku; ia menjaga memori kolektif. Di Graha Pusat Literasi, kami menjaga warisan lokal Magetan.", "img": "/assets/images/placeholder-hero.jpg" },
        { "id": 2, "title": "Lebih dari Sekedar Membaca", "content": "", "img": "" },
        { "id": 3, "title": "Menikmati Literasi Bersama", "content": "", "img": "" },
        { "id": 4, "title": "Dari Literasi ke Aksi", "content": "", "img": "" },
        { "id": 5, "title": "Belajar, Bereksperimen, Berbagi", "content": "", "img": "" },
        { "id": 6, "title": "Literasi Berkembang Inovasi Dimulai", "content": "", "img": "" },
        { "id": 7, "title": "Literasi : Kisah dan Kasih", "content": "", "img": "" },
        { "id": 8, "title": "Literasi Hidup Disini", "content": "", "img": "" },
        { "id": 9, "title": "Saat Pengetahuan Bertemu Teknologi", "content": "", "img": "" },
        { "id": 10, "title": "Dari Membaca Menuju Mencipta", "content": "", "img": "" }
    ]>
</#if>

<style>
    /* Mengimpor Font Estetis */
    @import url('https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&family=Inter:wght@400;500;600&display=swap');
    
    /* ========================================================
       LAPISAN BATIK (Nempel di background #f7f0cb home.ftl)
       ======================================================== */
    .gpl-batik-layer {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/assets/images/batikspring.png"}'); 
        background-size: 600px;
        opacity: 0.4; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    /* ========================================================
       AREA GULIR KONTEN (Tanpa membuat ukuran fixed baru)
       ======================================================== */
    .gpl-content-flow {
        position: relative;
        z-index: 10; /* Berada di atas batik */
        width: 100%;
        min-height: 100%;
        padding: 80px 50px 120px; /* Jarak aman di dalam modal home.ftl */
        font-family: 'Inter', sans-serif;
        display: flex; flex-direction: column; align-items: center;
    }

    /* Tombol X Dinamis (Menghilang saat scroll) */
    .gpl-dynamic-close {
        position: absolute; top: 30px; right: 40px;
        font-size: 60px; color: #1e293b; font-weight: bold;
        cursor: pointer; z-index: 100;
        transition: opacity 0.3s ease, visibility 0.3s;
        line-height: 1; text-decoration: none;
    }
    .gpl-dynamic-close:hover { color: #dc2626; }

    /* ========================================================
       2. FEATURED CARD (BANNER UTAMA KACA)
       ======================================================== */
    .gpl-featured-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        width: 100%;
        border-radius: 50px;
        padding: 45px;
        margin-bottom: 70px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
        text-align: center;
        cursor: pointer; text-decoration: none; display: block;
        animation: fadeInUp 0.8s ease-out;
        transition: all 0.3s ease;
        border: 1px solid rgba(255,255,255,0.5);
    }
    .gpl-featured-card:hover { transform: translateY(-5px); box-shadow: 0 35px 60px -15px rgba(0, 0, 0, 0.15); }

    .gpl-featured-card img {
        width: 100%; height: 440px; object-fit: cover;
        border-radius: 30px; margin-bottom: 35px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        background-color: #e2e8f0;
    }

    .gpl-featured-card h2 {
        font-family: 'Gelasio', serif; font-size: 52px; font-weight: 700;
        color: #334155; margin-bottom: 20px; letter-spacing: -1px;
    }

    .gpl-featured-card p {
        font-family: 'Lato', sans-serif; font-size: 28px; color: #64748b;
        line-height: 1.6; padding: 0 30px; font-weight: 400;
    }

    /* ========================================================
       3. GRID ARTIKEL (3x3)
       ======================================================== */
    .gpl-grid-zone {
        display: grid; grid-template-columns: repeat(3, 1fr); gap: 45px;
        width: 100%; animation: fadeInUp 1s ease-out;
    }

    .gpl-grid-node {
        display: flex; flex-direction: column; align-items: center;
        text-align: center; cursor: pointer; text-decoration: none;
        transition: transform 0.2s ease;
    }
    .gpl-grid-node:hover { transform: translateY(-5px); }

    .gpl-grid-thumb {
        width: 100%; aspect-ratio: 1/1;
        background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e1 100%);
        border-radius: 24px; margin-bottom: 22px; overflow: hidden;
        box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        border: 1px solid rgba(255,255,255,0.6);
        display: flex; align-items: center; justify-content: center;
    }
    .gpl-grid-thumb img { width: 100%; height: 100%; object-fit: cover; }

    .gpl-grid-label {
        font-family: 'Lato', sans-serif; font-size: 24px; font-weight: 700;
        color: #1e293b; line-height: 1.4; max-width: 90%;
    }

    /* Animasi Muncul dari Bawah */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(40px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div class="gpl-batik-layer"></div>

<a href="javascript:void(0)" onclick="closeAllOverlays()" id="gplArticleCloseBtn" class="gpl-dynamic-close">&times;</a>

<div class="gpl-content-flow">
    
    <#-- 1. FEATURED BANNER -->
    <#if articleData?size gt 0>
        <#assign main = articleData[0]>
        <a href="/articles-details/${main.id}" class="gpl-featured-card">
            <#if main.img?? && main.img?has_content>
                <img src="${main.img}" alt="${main.title!''}">
            <#elseif (main.id > 0)>
                <img src="/admin/articles/image/${main.id}" onerror="this.style.display='none'">
                <i class="fas fa-image text-8xl text-slate-400 absolute mt-[180px]" style="z-index:-1;"></i>
            <#else>
                <div style="width:100%; height:440px; background:#e2e8f0; border-radius:30px; margin-bottom:35px; display:flex; align-items:center; justify-content:center;">
                    <i class="fas fa-image text-8xl text-slate-400"></i>
                </div>
            </#if>
            
            <h2>${main.title!""}</h2>
            <p>${main.content!""}</p>
        </a>
    </#if>

    <#-- 2. GRID 3x3 -->
    <div class="gpl-grid-zone">
        <#list articleData as item>
            <#if item?index gt 0 && item?index lt 10>
                <a href="/articles-details/${item.id}" class="gpl-grid-node">
                    <div class="gpl-grid-thumb">
                        <#if item.img?? && item.img?has_content>
                            <img src="${item.img}" alt="${item.title!''}">
                        <#elseif (item.id > 0)>
                            <img src="/admin/articles/image/${item.id}" onerror="this.style.display='none'">
                            <i class="fas fa-image text-6xl text-slate-400 absolute" style="z-index:-1;"></i>
                        <#else>
                            <i class="fas fa-image text-6xl text-slate-400"></i>
                        </#if>
                    </div>
                    <span class="gpl-grid-label">${item.title!""}</span>
                </a>
            </#if>
        </#list>
    </div>

</div>

<script>
    // Fitur menyembunyikan tombol "X" saat menggulir ke bawah
    document.addEventListener("DOMContentLoaded", function() {
        // Mencari elemen scroll dari home.ftl yang membungkus file ini
        const articleScrollArea = document.getElementById('article-scroll-area');
        const closeBtn = document.getElementById('gplArticleCloseBtn');

        if(articleScrollArea && closeBtn) {
            articleScrollArea.addEventListener('scroll', () => {
                if (articleScrollArea.scrollTop > 80) {
                    closeBtn.style.opacity = '0';
                    closeBtn.style.visibility = 'hidden';
                } else {
                    closeBtn.style.opacity = '1';
                    closeBtn.style.visibility = 'visible';
                }
            });
        }
    });
</script>