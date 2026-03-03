<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="icon" type="image/png" href="/images/backoffice/Ellipse 2.png">
    <title>Daftar Artikel - Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        body { 
            background-color: #1a1a1a; 
            margin: 0; 
            padding: 0; 
            height: 100vh; 
            width: 100vw; 
            overflow: hidden; 
            position: relative;
        }

        /* KANVAS UTAMA */
        #kios-canvas {
            width: 1080px; height: 1920px;
            background-color: #f7f0cb; 
            position: absolute;
            top: 50%;
            left: 50%;
            overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 100px rgba(0,0,0,0.5);
            transform-origin: center center;
            transform: translate(-50%, -50%);
        }

        .close-btn {
            position: absolute;
            top: 28px;
            right: 38px;
            font-size: 60px;
            color: #1F1F1F;
            cursor: pointer;
            z-index: 1000;
            font-family: 'Inter', sans-serif;
            line-height: 1;
        }

        .scroll-area {
            flex: 1;
            overflow-y: auto;
            padding: 82px 40px 48px;
            z-index: 10;
            scrollbar-width: none;
        }
        .scroll-area::-webkit-scrollbar { display: none; }

        .hero-card {
            background: #f7f7f7;
            border-radius: 24px;
            padding: 24px;
            margin-top: 62px;
            margin-bottom: 26px;
        }

        .hero-image {
            width: 100%;
            height: 430px;
            border-radius: 20px;
            object-fit: cover;
            background: #cfcfcf;
            display: block;
            transition: opacity 0.35s ease;
        }

        .hero-title {
            text-align: center;
            margin-top: 14px;
            font-family: 'Gelasio', serif;
            font-size: 56px;
            line-height: 1.1;
            color: rgba(71, 85, 105, 0.85);
            transition: opacity 0.35s ease;
        }

        .hero-desc {
            margin: 14px auto 0;
            max-width: 90%;
            text-align: center;
            font-family: 'Inter', sans-serif;
            font-size: 36px;
            line-height: 1.25;
            color: #6b8f82;
            transition: opacity 0.35s ease;
        }

        .article-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px 24px;
        }

        .grid-item {
            cursor: pointer;
        }

        .grid-thumb {
            width: 100%;
            height: 250px;
            border-radius: 2px;
            object-fit: cover;
            background: #cfcfcf;
            display: block;
        }

        .grid-title {
            margin-top: 12px;
            text-align: center;
            font-family: 'Inter', sans-serif;
            font-size: 40px;
            line-height: 1.1;
            color: #1f1f1f;
            min-height: 86px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .empty-text {
            text-align: center;
            font-family: 'Inter', sans-serif;
            font-size: 34px;
            color: #64748b;
            padding: 40px 20px;
        }
    </style>
</head>
<body>

    <div id="kios-canvas">
        <div class="close-btn" onclick="window.location.href='/home'">x</div>

        <div id="scrollArea" class="scroll-area">
            <#if articles?? && articles?size gt 0>
                <#assign featured = articles[0]>
                <div id="featuredCard" class="hero-card" onclick="openFeatured()">
                    <#if featured.coverImage?? && featured.coverImage?has_content>
                        <img id="featuredImage" src="/admin/articles/image/${featured.id?c}" class="hero-image" alt="${featured.title!""}" onerror="this.onerror=null;this.src='https://placehold.co/900x430?text=Artikel';">
                    <#else>
                        <img id="featuredImage" src="https://placehold.co/900x430?text=Artikel" class="hero-image" alt="${featured.title!""}">
                    </#if>

                    <div id="featuredTitle" class="hero-title">${featured.title!"Memori milik kita"}</div>
                    <div id="featuredDesc" class="hero-desc">
                        <#if featured.content?? && featured.content?has_content>
                            ${featured.content?replace("<[^>]*>", "", "r")?truncate(140, "...")}
                        <#else>
                            Sebuah perpustakaan modern tidak hanya menyimpan buku; ia menjaga memori kolektif.
                        </#if>
                    </div>
                </div>

                <div class="article-grid">
                    <#list articles as article>
                        <div class="grid-item" onclick="window.location.href='/articles/detail?id=${article.id?c}'">
                            <#if article.coverImage?? && article.coverImage?has_content>
                                <img src="/admin/articles/image/${article.id?c}" class="grid-thumb" alt="${article.title!""}" onerror="this.onerror=null;this.src='https://placehold.co/260x250?text=Artikel';">
                            <#else>
                                <img src="https://placehold.co/260x250?text=Artikel" class="grid-thumb" alt="${article.title!""}">
                            </#if>
                            <div class="grid-title">${article.title!"Tanpa Judul"}</div>
                        </div>
                    </#list>
                </div>
            <#else>
                <div class="empty-text" style="padding-top: 180px;">
                    Belum ada artikel yang dipublikasikan.
                </div>
            </#if>
        </div>
    </div>

    <script>
        let featuredIndex = 0;
        let featuredItems = [];

        function autoScale() {
            const canvas = document.getElementById('kios-canvas');
            const scale = Math.min(window.innerWidth / 1080, window.innerHeight / 1920);
            canvas.style.transform = "translate(-50%, -50%) scale(" + scale + ")";
        }

        function openFeatured() {
            if (featuredItems.length > 0) {
                window.location.href = '/articles/detail?id=' + featuredItems[featuredIndex].id;
            }
        }

        function renderFeatured(index) {
            const featuredImage = document.getElementById('featuredImage');
            const featuredTitle = document.getElementById('featuredTitle');
            const featuredDesc = document.getElementById('featuredDesc');
            if (!featuredImage || !featuredTitle || !featuredDesc || featuredItems.length === 0) {
                return;
            }

            const item = featuredItems[index];
            featuredImage.style.opacity = '0.35';
            featuredTitle.style.opacity = '0.35';
            featuredDesc.style.opacity = '0.35';

            setTimeout(function () {
                featuredImage.src = item.image;
                featuredImage.alt = item.title;
                featuredTitle.textContent = item.title;
                featuredDesc.textContent = item.desc;
                featuredImage.style.opacity = '1';
                featuredTitle.style.opacity = '1';
                featuredDesc.style.opacity = '1';
            }, 180);
        }

        function initFeaturedCarousel() {
            <#if articles?? && articles?size gt 0>
            featuredItems = [
                <#list articles as article>
                {
                    id: ${article.id?c},
                    title: "${(article.title!"Tanpa Judul")?js_string}",
                    desc: "${((article.content!"Sebuah perpustakaan modern tidak hanya menyimpan buku; ia menjaga memori kolektif.")?replace("<[^>]*>", "", "r")?truncate(140, "..."))?js_string}",
                    image: "<#if article.coverImage?? && article.coverImage?has_content>/admin/articles/image/${article.id?c}<#else>https://placehold.co/900x430?text=Artikel</#if>"
                }<#if article_has_next>,</#if>
                </#list>
            ];
            if (featuredItems.length > 1) {
                setInterval(function () {
                    let nextIndex = Math.floor(Math.random() * featuredItems.length);
                    if (featuredItems.length > 1) {
                        while (nextIndex === featuredIndex) {
                            nextIndex = Math.floor(Math.random() * featuredItems.length);
                        }
                    }
                    featuredIndex = nextIndex;
                    renderFeatured(featuredIndex);
                }, 3000);
            }
            </#if>
        }

        window.addEventListener('load', function () {
            autoScale();
            initFeaturedCarousel();
        });
        window.addEventListener('resize', autoScale);
    </script>
</body>
</html>