<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Profil - Graha Pusat Literasi Magetan"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400&family=Gelasio:ital,wght@0,400;0,700;1,700&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA: Terkunci 864x1536 */
        #profile-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 120px rgba(0,0,0,0.6);
            transform-origin: center center;
        }

        .batik-overlay {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"batikspring.png"}'); 
            background-size: 450px;
            opacity: 0.55; mix-blend-mode: multiply;
            pointer-events: none; z-index: 1;
        }

        /* TOMBOL KELUAR: Pojok Kanan Atas & Proporsional */
        .close-btn {
            position: absolute; 
            top: 40px; 
            right: 50px; 
            font-size: 60px; 
            color: #334155;
            cursor: pointer; 
            z-index: 1000; 
            line-height: 1; 
            font-family: 'Inter', sans-serif;
            transition: opacity 0.3s ease;
        }

        /* AREA GULIR: Whitespace 110px */
        .content-scroll {
            flex: 1; overflow-y: auto;
            padding: 0 110px; 
            z-index: 10;
            scrollbar-width: none;
            scroll-behavior: smooth;
        }
        .content-scroll::-webkit-scrollbar { display: none; }

        .header-section { text-align: center; padding-top: 180px; }
        
        .profile-img { 
            width: 100%; height: 580px; 
            object-fit: cover; border-radius: 50px; 
            box-shadow: 0 20px 40px rgba(0,0,0,0.12); 
            margin-bottom: 60px; 
        }

        .title-profile { font-family: 'Gelasio'; color: #334155; font-size: 60px; font-weight: bold; margin-bottom: 40px; line-height: 1.2; }
        .quote-profile { font-family: 'Gelasio'; font-style: italic; color: #475569; font-size: 28px; line-height: 1.6; }

        /* PEMISAH HIJAU BAMBU */
        .green-divider {
            width: 100%; height: 3px;
            background-color: #6B8A7A; margin: 70px auto;
            border-radius: 50px; opacity: 0.5;
        }

        .title-line {
            width: 140px; height: 2px;
            background-color: #334155; margin: 20px auto 50px auto;
            opacity: 0.3;
        }

        /* BINGKAI PETA */
        .map-frame {
            width: 100%; height: 500px;
            border-radius: 45px; overflow: hidden;
            border: 3px solid #334155;
            box-shadow: 0 15px 40px rgba(0,0,0,0.08);
            margin-bottom: 50px;
        }

        .ink-text { color: #334155; }
    </style>
</head>
<body>

    <div id="profile-canvas">
        <div class="batik-overlay"></div>
        
        <div class="close-btn" id="closeBtn" onclick="window.history.back()">X</div>

        <div class="content-scroll" id="scrollArea">
            
            <header class="header-section">
                <img src="${profileImgPath!"profil.png"}" alt="Gedung Graha" class="profile-img">
                <h1 class="title-profile">${mainTitle!"Profil Graha Pusat <br>Literasi Magetan"}</h1>
                <p class="quote-profile">
                    ${quoteText!"\"Wadah masyarakat dalam melakukan kegiatan Literasi di Kabupaten Magetan, berfokus pada penumbuhan minat literasi dan budaya daerah.\""}
                </p>
            </header>

            <div class="green-divider"></div>

            <article class="w-full flex flex-col items-center gap-20 text-center">
                
                <#-- VISI & MISI -->
                <div class="w-full">
                    <h2 class="text-[#6B8A7A] text-[34px] font-bold font-['Gelasio'] uppercase tracking-[0.4em] mb-4">Visi & Misi</h2>
                    <div class="title-line"></div>
                    <div class="space-y-10 px-4">
                        <p class="font-['Gelasio'] text-[36px] font-bold ink-text leading-snug">${visionStatement!"“Masyarakat Magetan yang SMART semakin mantap dan lebih sejahtera”"}</p>
                        <div class="font-['Lato'] text-[26px] text-slate-700 leading-relaxed">
                            <#if missions??>
                                <#list missions as mission>
                                    <p>• ${mission}</p>
                                </#list>
                            <#else>
                                <p>• Meningkatkan percepatan dan perluasan pembentukan sumber daya manusia yang SMART.</p>
                                <p>• Mengembangkan penyelenggaraan tata pemerintahan yang baik dan manajemen pemerintahan yang bersih, profesional dan adil.</p>
                            </#if>
                        </div>
                    </div>
                </div>

                <#-- SEJARAH LENGKAP -->
                <div class="w-full">
                    <h2 class="text-[#6B8A7A] text-[34px] font-bold font-['Gelasio'] uppercase tracking-[0.4em] mb-4">Sejarah</h2>
                    <div class="title-line"></div>
                    <div class="font-['Lato'] text-[26px] text-slate-700 font-bold leading-relaxed space-y-10 italic text-center px-4">
                        <#if historyParagraphs??>
                            <#list historyParagraphs as paragraph>
                                <p>${paragraph}</p>
                            </#list>
                        <#else>
                            <p>Pendirian Graha Pusat Literasi Magetan merupakan wujud nyata dari komitmen pemerintah daerah pasca diraihnya penghargaan sebagai Kabupaten Literasi pada akhir 2019...</p>
                            <p>Melalui sinergi dengan Perpustakaan Nasional RI dan dukungan Dana Alokasi Khusus (DAK), pembangunan gedung ini dilaksanakan sepanjang tahun 2020 hingga 2021...</p>
                            <p><strong>Transformasi dan Layanan:</strong><br>
                            Peresmian (17 Desember 2021): Diresmikan sebagai ruang publik yang inklusif untuk belajar dan berkarya...</p>
                        </#if>
                    </div>
                </div>

                <#-- INFORMASI UMUM -->
                <div class="w-full">
                    <h2 class="text-[#6B8A7A] text-[34px] font-bold font-['Gelasio'] uppercase tracking-[0.4em] mb-4">Informasi Umum</h2>
                    <div class="title-line"></div>
                    <div class="flex flex-col items-center gap-10 font-['Lato'] text-center">
                        <#if infoItems??>
                            <#list infoItems as item>
                                <div>
                                    <span class="text-slate-400 uppercase text-xs tracking-[0.3em] block mb-2">${item.label}</span>
                                    <p class="ink-text text-[28px] font-bold">${item.value}</p>
                                </div>
                            </#list>
                        <#else>
                            <div>
                                <span class="text-slate-400 uppercase text-xs tracking-[0.3em] block mb-2">Naungan</span>
                                <p class="ink-text text-[28px] font-bold">Dinas Kearsipan dan Perpustakaan Umum Kabupaten Magetan</p>
                            </div>
                            <div>
                                <span class="text-slate-400 uppercase text-xs tracking-[0.3em] block mb-2">Lokasi Utama</span>
                                <p class="ink-text text-[28px] font-bold">Jl. Raya Sarangan Km 10, Plaosan II, Kec. Plaosan, Kab. Magetan</p>
                            </div>
                        </#if>
                    </div>
                </div>
            </article>

            <div class="green-divider"></div>

            <footer class="w-full flex flex-col items-center gap-16 pb-60 text-center">
                <div class="map-frame">
                    <iframe 
                        src="${mapSrc!"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3954.524535316315!2d111.24641567476412!3d-7.62660149238865!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e79910400000001%3A0x2e79910400000001!2sGraha%20Pusat%20Literasi%20Kabupaten%20Magetan!5e0!3m2!1sid!2sid!4v1700000000000!5m2!1sid!2sid"}" 
                        width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy">
                    </iframe>
                </div>
                
                <div class="flex gap-48">
                    <a href="${whatsappLink!"#"}" target="_blank" class="text-[90px] ink-text">
                        <i class="fab fa-whatsapp"></i>
                    </a>
                    <a href="${instagramLink!"#"}" target="_blank" class="text-[90px] ink-text">
                        <i class="fab fa-instagram"></i>
                    </a>
                </div>
                <p class="font-['Lato'] text-[26px] text-slate-400 font-bold tracking-[0.5em]">${socialHandle!"@MAGETAN_LIB | 0857-0638-0204"}</p>
            </footer>

        </div>
    </div>

    <script>
        const scrollArea = document.getElementById('scrollArea');
        const closeBtn = document.getElementById('closeBtn');

        scrollArea.addEventListener('scroll', () => {
            if (scrollArea.scrollTop > 100) {
                closeBtn.style.opacity = '0';
                closeBtn.style.pointerEvents = 'none';
            } else {
                closeBtn.style.opacity = '1';
                closeBtn.style.pointerEvents = 'auto';
            }
        });

        function scaleCanvas() {
            const canvas = document.getElementById('profile-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>