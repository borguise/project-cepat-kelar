<#-- articles.ftl - VERSI PREMIUM ESTETIS (OVERLAY ARTIKEL) -->

<style>
    /* 1. KONTAINER UTAMA DENGAN TEKSTUR BATIK */
    .articles-premium-wrapper {
        background-color: #f7f0cb; 
        min-height: 100%;
        width: 100%;
        padding: 80px 50px 120px;
        font-family: 'Inter', sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
    }

    /* Overlay Batik Halus agar Estetis */
    .articles-premium-wrapper::before {
        content: "";
        position: absolute; inset: 0;
        background-image: url('/images/frontoffice/batikspring.png'); 
        background-size: 600px;
        opacity: 0.4;
        mix-blend-mode: multiply;
        pointer-events: none;
    }

    /* 2. FEATURED CARD (ANIMASI & ELEGAN) */
    .featured-card-premium {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        width: 100%;
        border-radius: 50px;
        padding: 45px;
        margin-top: 40px;
        margin-bottom: 70px;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
        text-align: center;
        cursor: pointer;
        z-index: 10;
        animation: fadeInUp 0.8s ease-out;
        transition: all 0.3s ease;
        border: 1px solid rgba(255,255,255,0.5);
    }

    .featured-card-premium img {
        width: 100%;
        height: 440px;
        object-fit: cover;
        border-radius: 30px;
        margin-bottom: 35px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    .featured-card-premium h2 {
        font-family: 'Gelasio', serif;
        font-size: 52px;
        font-weight: 700;
        color: #334155;
        margin-bottom: 20px;
        letter-spacing: -1px;
    }

    .featured-card-premium p {
        font-family: 'Lato', sans-serif;
        font-size: 28px;
        color: #64748b;
        line-height: 1.6;
        padding: 0 30px;
        font-weight: 400;
    }

    /* 3. GRID ARTIKEL (3x3 DENGAN EFEK HOVER/ACTIVE) */
    .articles-grid-premium {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 45px;
        width: 100%;
        z-index: 10;
        animation: fadeInUp 1s ease-out;
    }

    .grid-item-premium {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        cursor: pointer;
        transition: transform 0.2s ease;
    }
    
    .grid-item-premium:active { transform: scale(0.95); }

    .grid-thumb-premium {
        width: 100%;
        aspect-ratio: 1/1;
        background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e1 100%);
        border-radius: 24px;
        margin-bottom: 22px;
        overflow: hidden;
        box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        border: 1px solid rgba(255,255,255,0.6);
    }

    .grid-thumb-premium img {
        width: 100%; height: 100%; object-fit: cover;
    }

    .grid-label-premium {
        font-family: 'Lato', sans-serif;
        font-size: 24px;
        font-weight: 700;
        color: #1e293b;
        line-height: 1.4;
        max-width: 90%;
    }

    /* KEYFRAMES ANIMASI */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(40px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* Hide Scrollbar but keep functionality */
    .scrollbar-hide::-webkit-scrollbar { display: none; }
</style>

<div class="articles-premium-wrapper scrollbar-hide">
    
    <#assign articleData = articles![]>
    
    <#if articleData?size == 0>
        <#assign articleData = [
            { "id": 0, "title": "Memori Milik Kita", "content": "Sebuah perpustakaan modern tidak hanya menyimpan buku; ia menjaga memori kolektif. Di Graha Pusat Literasi, kami menjaga warisan lokal Magetan.", "img": "/images/frontoffice/profil.png" },
            { "id": 1, "title": "Lebih dari Sekedar Membaca" },
            { "id": 2, "title": "Menikmati Literasi Bersama" },
            { "id": 3, "title": "Dari Literasi ke Aksi" },
            { "id": 4, "title": "Belajar & Berbagi" },
            { "id": 5, "title": "Inovasi Tanpa Batas" },
            { "id": 6, "title": "Kisah dan Kasih" },
            { "id": 7, "title": "Literasi Hidup Disini" },
            { "id": 8, "title": "Pengetahuan Jadi Kreasi" },
            { "id": 9, "title": "Membaca Menuju Mencipta" }
        ]>
    </#if>

    <#-- 1. FEATURED BANNER -->
    <#assign main = articleData[0]>
    <div class="featured-card-premium" onclick="location.href='/articles/detail?id=${main.id?c}'">
        <#if main.img?? && main.img?has_content>
            <img src="${main.img}">
        <#elseif (main.id > 0)>
            <img src="/admin/articles/image/${main.id?c}" onerror="this.src='/images/frontoffice/profil.png'">
        <#else>
            <img src="/images/frontoffice/profil.png">
        </#if>
        
        <h2>${main.title}</h2>
        <p>${main.content!""}</p>
    </div>

    <#-- 2. GRID 3x3 -->
    <div class="articles-grid-premium">
        <#list articleData as item>
            <#if item?index gt 0>
                <div class="grid-item-premium" onclick="location.href='/articles/detail?id=${item.id?c}'">
                    <div class="grid-thumb-premium">
                        <#if item.img?? && item.img?has_content>
                            <img src="${item.img}">
                        <#elseif (item.id > 0)>
                            <img src="/admin/articles/image/${item.id?c}">
                        </#if>
                    </div>
                    <span class="grid-label-premium">${item.title}</span>
                </div>
            </#if>
        </#list>
    </div>
</div>