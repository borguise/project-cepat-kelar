<#-- profile.ftl - FRAGMENT KONTEN PROFIL LENGKAP -->
<link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400&family=Gelasio:ital,wght@0,400;0,700;1,700&family=Inter:wght@400;700;900&display=swap" rel="stylesheet">

<style>
    .profile-overlay-wrapper {
        background-color: #f7f0cb; 
        padding: 0 110px 100px 110px;
        font-family: 'Gelasio', serif;
        position: relative;
        min-height: 100%;
        width: 100%;
    }

    .profile-batik-bg {
        position: absolute; inset: 0;
        background-image: url('${basePath!"/images/frontoffice"}/batikspring.png'); 
        background-size: 450px;
        opacity: 0.55; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    .profile-content-inner { position: relative; z-index: 10; display: flex; flex-direction: column; align-items: center; }
    
    .header-section { text-align: center; padding-top: 180px; width: 100%; }
    .profile-img-styled { 
        width: 100%; height: 400px; 
        object-fit: cover; border-radius: 50px; 
        box-shadow: 0 20px 40px rgba(0,0,0,0.12); 
        margin-bottom: 60px; 
    }

    .title-profile-text { font-size: 60px; font-weight: bold; color: #334155; margin-bottom: 40px; line-height: 1.2; }
    .quote-profile-text { font-style: italic; color: #475569; font-size: 28px; line-height: 1.6; }

    .green-divider-line {
        width: 100%; height: 3px;
        background-color: #6B8A7A; margin: 70px auto;
        border-radius: 50px; opacity: 0.5;
    }

    .title-line-short {
        width: 140px; height: 2px;
        background-color: #334155; margin: 20px auto 50px auto;
        opacity: 0.3;
    }

    .map-frame-styled {
        width: 100%; height: 500px;
        border-radius: 45px; overflow: hidden;
        border: 3px solid #334155;
        box-shadow: 0 15px 40px rgba(0,0,0,0.08);
        margin-bottom: 50px;
        background: white;
    }

    .ink-text-color { color: #334155; }
</style>

<div class="profile-overlay-wrapper">
    <div class="profile-batik-bg"></div>
    
    <div class="profile-content-inner">
        <header class="header-section">
            <img src="${basePath!"/images/frontoffice"}/profil.png" alt="Gedung Graha" class="profile-img-styled">
            <h1 class="title-profile-text">Profil Graha Pusat <br>Literasi Magetan</h1>
            <p class="quote-profile-text">
                "Wadah masyarakat dalam melakukan kegiatan Literasi di Kabupaten Magetan, berfokus pada penumbuhan minat literasi dan budaya daerah."
            </p>
        </header>

        <div class="green-divider-line"></div>

        <article class="w-full flex flex-col items-center gap-20 text-center">
            
            <#-- VISI & MISI -->
            <div class="w-full">
                <h2 class="text-[#6B8A7A] text-[34px] font-bold font-['Gelasio'] uppercase tracking-[0.4em] mb-4">Visi & Misi</h2>
                <div class="title-line-short"></div>
                <div class="space-y-10 px-4">
                    <#-- PERBAIKAN: Mengganti kutip lengkung dengan kutip lurus standar -->
                    <p class="font-['Gelasio'] text-[36px] font-bold ink-text-color leading-snug">"Masyarakat Magetan yang SMART semakin mantap dan lebih sejahtera"</p>
                    <div class="font-['Lato'] text-[26px] text-slate-700 leading-relaxed">
                        <#-- PERBAIKAN: Mengganti simbol bullet dengan kode HTML &bull; -->
                        <p>&bull; Meningkatkan percepatan dan perluasan pembentukan sumber daya manusia yang SMART.</p>
                        <p>&bull; Mengembangkan penyelenggaraan tata pemerintahan yang baik dan manajemen pemerintahan yang bersih, profesional dan adil.</p>
                    </div>
                </div>
            </div>

            <#-- SEJARAH -->
            <div class="w-full">
                <h2 class="text-[#6B8A7A] text-[34px] font-bold font-['Gelasio'] uppercase tracking-[0.4em] mb-4">Sejarah</h2>
                <div class="title-line-short"></div>
                <div class="font-['Lato'] text-[26px] text-slate-700 font-bold leading-relaxed space-y-10 italic text-center px-4">
                    <p>Pendirian Graha Pusat Literasi Magetan merupakan wujud nyata dari komitmen pemerintah daerah pasca diraihnya penghargaan sebagai Kabupaten Literasi pada akhir 2019. Prestasi tersebut menjadi momentum bagi Pemerintah Kabupaten Magetan untuk memperkuat ekosistem literasi masyarakat, khususnya melalui pengembangan Creative Writing Center sebagai wadah kreativitas penulis lokal.</p>
                    
                    <p>Melalui sinergi dengan Perpustakaan Nasional RI dan dukungan Dana Alokasi Khusus (DAK), pembangunan gedung ini dilaksanakan sepanjang tahun 2020 hingga 2021. Pemilihan lokasi di Jl. Raya Sarangan Km 10, Plaosan, terbilang sangat strategis; berada di jalur utama menuju Telaga Sarangan, gedung ini didesain untuk menjalankan fungsi ganda sebagai pusat pembelajaran sekaligus destinasi wisata edukatif.</p>
                    
                    <p><strong>Transformasi dan Layanan:</strong><br>
                    Peresmian (17 Desember 2021): Diresmikan sebagai ruang publik yang inklusif untuk belajar dan berkarya.<br>
                    Penguatan Kapasitas (2022): Menghadirkan layanan ruang baca, koleksi digital, dan pojok konten lokal yang mulai rutin diselenggarakan.<br>
                    Wisata Literasi (Akhir 2023): Memperkenalkan konsep inovasi memadukan aktivitas intelektual dengan pengalaman berwisata di tengah sejuknya suasana Plaosan.</p>
                </div>
            </div>

            <#-- INFORMASI UMUM -->
            <div class="w-full">
                <h2 class="text-[#6B8A7A] text-[34px] font-bold font-['Gelasio'] uppercase tracking-[0.4em] mb-4">Informasi Umum</h2>
                <div class="title-line-short"></div>
                <div class="flex flex-col items-center gap-10 font-['Lato'] text-center">
                    <div>
                        <span class="text-slate-400 uppercase text-xs tracking-[0.3em] block mb-2">Naungan</span>
                        <p class="ink-text-color text-[28px] font-bold">Dinas Kearsipan dan Perpustakaan Umum Kabupaten Magetan</p>
                    </div>
                    <div>
                        <span class="text-slate-400 uppercase text-xs tracking-[0.3em] block mb-2">Kepala Dinas</span>
                        <p class="ink-text-color text-[28px] font-bold">Suhardi, S.Pd, M.Pd</p>
                    </div>
                    <div>
                        <span class="text-slate-400 uppercase text-xs tracking-[0.3em] block mb-2">Lokasi Utama</span>
                        <p class="ink-text-color text-[28px] font-bold">Jl. Raya Sarangan Km 10, Plaosan II, Kec. Plaosan, Kab. Magetan</p>
                    </div>
                </div>
            </div>
        </article>

        <div class="green-divider-line"></div>

        <footer class="w-full flex flex-col items-center gap-16 pb-20 text-center">
            <div class="map-frame-styled">
    <#-- LINK EMBED RESMI GOOGLE MAPS - GRAHA PUSAT LITERASI MAGETAN -->
    <iframe 
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3954.347313835485!2d111.23891467417466!3d-7.645733575635848!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e799195b6c93605%3A0x868d833a4176d655!2sGraha%20Pusat%20Literasi%20Kabupaten%20Magetan!5e0!3m2!1sid!2sid!4v1711347890000!5m2!1sid!2sid" 
        width="100%" 
        height="100%" 
        style="border:0;" 
        allowfullscreen="" 
        loading="lazy" 
        referrerpolicy="no-referrer-when-downgrade">
    </iframe>
</div>            
            <div class="flex gap-48">
                <a href="https://wa.me/6285706380204" target="_blank" class="text-[90px] ink-text-color hover:text-[#25D366] transition-colors">
                    <i class="fab fa-whatsapp"></i>
                </a>
                <a href="https://instagram.com/magetan_lib" target="_blank" class="text-[90px] ink-text-color hover:text-[#E1306C] transition-colors">
                    <i class="fab fa-instagram"></i>
                </a>
            </div>
            <p class="font-['Lato'] text-[26px] text-slate-400 font-bold tracking-[0.5em]">@MAGETAN_LIB | 0857-0638-0204</p>
        </footer>
    </div>
</div>