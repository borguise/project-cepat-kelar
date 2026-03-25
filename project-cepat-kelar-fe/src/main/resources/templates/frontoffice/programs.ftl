<#-- FRAGMENT PROGRAMS.FTL (DESAIN ZIGZAG 8 ITEM LAYANAN) -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400&family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">

<style>
    /* Transisi Halus untuk Tab */
    .tab-content { animation: fadeIn 0.5s ease-in-out; }
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

    /* NAVIGASI & HEADER */
    .main-title { font-family: 'Inter', sans-serif; font-size: 38px; font-weight: 900; color: #1a1a1a; line-height: 1.3; margin-bottom: 50px; padding: 0 50px; text-align: center; }
    
    .tab-container { display: inline-flex; background-color: #3730a3; padding: 5px; border-radius: 12px; gap: 8px; margin-bottom: 50px; }
    .tab-button { width: 165px; height: 44px; display: flex; align-items: center; justify-content: center; border-radius: 10px; font-family: 'Lato', sans-serif; font-size: 24px; color: white; cursor: pointer; transition: all 0.3s ease; }
    .tab-button.active { font-weight: bold; background-color: rgba(255,255,255,0.2); }

    /* PEMISAH HIJAU BAMBU */
    .thin-separator { border-top: 2px solid #6B8A7A; width: 85%; margin: 0 auto; opacity: 0.6; }

    /* UNIT LAYANAN SEAMLESS ZIGZAG */
    .service-unit { display: flex; align-items: center; gap: 40px; margin: 80px 0; position: relative; }
    .service-unit.reverse { flex-direction: row-reverse; }

    /* TEKS & GAMBAR */
    .service-text { flex: 1; display: flex; flex-direction: column; gap: 15px; text-align: center; align-items: center; }
    .service-title { font-family: 'Inter', sans-serif; font-size: 32px; font-weight: 900; color: #000; }
    .service-desc { font-family: 'Inter', sans-serif; font-size: 26px; color: #1a1a1a; line-height: 1.4; font-weight: 600; }
    .service-link { font-family: 'Inter', sans-serif; font-size: 26px; color: #3730a3; font-weight: 800; text-decoration: underline; transition: color 0.3s; }
    .service-link:hover { color: #1e1b4b; }
    .service-img { width: 260px; height: 320px; border-radius: 40px; object-fit: cover; box-shadow: 0 15px 30px rgba(0,0,0,0.12); }

    /* HINT SCROLL (Panah Bawah) */
    .scroll-hint-wrapper { position: absolute; bottom: 30px; left: 50%; transform: translateX(-50%); z-index: 100; transition: opacity 0.5s ease; cursor: pointer; }
    .arrow-icon { font-size: 60px; color: #1a1a1a; opacity: 0.7; animation: bounce 2s infinite; }
    @keyframes bounce { 0%, 20%, 50%, 80%, 100% {transform: translateY(0);} 40% {transform: translateY(-20px);} }
</style>

<div class="relative min-h-full -mx-[50px] -my-[50px] px-[50px] py-[70px] flex flex-col" id="programs-wrapper">
    
    <div class="absolute inset-0 z-0 pointer-events-none opacity-40 mix-blend-multiply" 
         style="background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); background-size: 500px; background-repeat: repeat;">
    </div>

    <div class="relative z-10 flex flex-col flex-grow w-full max-w-4xl mx-auto">
        
        <div class="text-center pt-8">
            <h1 class="main-title">Layanan - layanan untuk pengunjung<br>Graha Pusat Literasi Kabupaten Magetan</h1>
            <div class="tab-container">
                <div id="btn-layanan" onclick="switchTab('layanan')" class="tab-button active">Layanan</div>
                <div id="btn-program" onclick="switchTab('program')" class="tab-button">Kegiatan</div>
            </div>
        </div>

        <div id="tab-layanan" class="tab-content flex-grow flex flex-col">
            
            <div class="thin-separator" style="margin-bottom: 40px;"></div>

            <div class="service-unit reverse">
                <img src="${basePath}/umum.png" class="service-img" alt="Baca Ditempat" onerror="this.src='${basePath}/layanan_baca.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Baca Ditempat</h2>
                    <p class="service-desc">Ruang tenang untuk menikmati bacaan dan meluangkan waktu bersama buku.</p>
                    <a href="#" class="service-link">Baca ceritanya di sini.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit">
                <img src="${basePath}/anak.png" class="service-img" alt="Ruang Baca Anak" onerror="this.src='${basePath}/layanan_anak.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Ruang Baca Anak</h2>
                    <p class="service-desc">Ruang ramah anak untuk membaca, bermain, dan mengenal literasi sejak dini.</p>
                    <a href="#" class="service-link">Jelajahi selengkapnya.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit reverse">
                <img src="${basePath}/berkelompok.png" class="service-img" alt="Kunjungan Berkelompok" onerror="this.src='${basePath}/layanan_kunjungan.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Kunjungan Berkelompok</h2>
                    <p class="service-desc">Pengalaman literasi yang lebih seru melalui kunjungan dan kebersamaan.</p>
                    <a href="#" class="service-link">Baca ceritanya di sini.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit">
                <img src="${basePath}/member.png" class="service-img" alt="Pendaftaran Anggota" onerror="this.src='${basePath}/layanan_baca.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Pendaftaran Anggota</h2>
                    <p class="service-desc">Langkah awal untuk menikmati layanan dan koleksi perpustakaan secara lebih luas.</p>
                    <a href="#" class="service-link">Jelajahi selengkapnya.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit reverse">
                <img src="${basePath}/sirkulasi.png" class="service-img" alt="Layanan Sirkulasi" onerror="this.src='${basePath}/layanan_baca.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Sirkulasi</h2>
                    <p class="service-desc">Tempat buku berpindah tangan dan cerita terus berlanjut.</p>
                    <a href="#" class="service-link">Baca ceritanya di sini.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit">
                <img src="${basePath}/komputer.png" class="service-img" alt="Layanan Lab. Komputer" onerror="this.src='${basePath}/layanan_baca.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Lab. Komputer</h2>
                    <p class="service-desc">Ruang literasi digital untuk menelusuri dan mengembangkan informasi.</p>
                    <a href="#" class="service-link">Jelajahi selengkapnya.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit reverse">
                <img src="${basePath}/laktasi.jpg" class="service-img" alt="Layanan Ruang Laktasi" onerror="this.src='${basePath}/layanan_baca.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Ruang Laktasi</h2>
                    <p class="service-desc">Ruang nyaman dan privat bagi ibu dan anak di tengah aktivitas literasi.</p>
                    <a href="#" class="service-link">Baca ceritanya di sini.</a>
                </div>
            </div>
            <div class="thin-separator"></div>

            <div class="service-unit" style="margin-bottom: 120px;">
                <img src="${basePath}/bangunan-copy-0.jpg" class="service-img" alt="Layanan Pemanfaatan Ruang" onerror="this.src='${basePath}/layanan_baca.png'">
                <div class="service-text">
                    <h2 class="service-title">Layanan Pemanfaatan Ruang</h2>
                    <p class="service-desc">Ruang terbuka untuk berkegiatan, berdiskusi, dan berbagi ide literasi.</p>
                    <a href="#" class="service-link">Jelajahi selengkapnya.</a>
                </div>
            </div>

        </div>

        <div id="tab-program" class="tab-content flex-grow flex flex-col hidden">
            <div class="thin-separator" style="margin-bottom: 40px;"></div>
            
            <div class="text-center mt-10">
                <i class="fas fa-calendar-alt text-[#3730a3] text-6xl mb-6"></i>
                <h2 class="service-title">Kegiatan Literasi</h2>
                <p class="service-desc mt-4">Jadwal kegiatan rutin dan khusus akan segera diperbarui. Pantau terus informasi terbaru dari kami.</p>
            </div>
        </div>

    </div>

    <div class="scroll-hint-wrapper" id="scrollHint" onclick="scrollDown()">
        <i class="fas fa-chevron-down arrow-icon"></i>
    </div>

</div>

<script>
    // --- 1. Logika Tab Layanan vs Kegiatan ---
    function switchTab(tabName) {
        const tabLayanan = document.getElementById('tab-layanan');
        const tabProgram = document.getElementById('tab-program');
        const btnLayanan = document.getElementById('btn-layanan');
        const btnProgram = document.getElementById('btn-program');

        // Reset class active
        btnLayanan.classList.remove('active');
        btnProgram.classList.remove('active');
        tabLayanan.classList.add('hidden');
        tabProgram.classList.add('hidden');

        // Aktifkan yang dipilih
        if (tabName === 'layanan') {
            tabLayanan.classList.remove('hidden');
            btnLayanan.classList.add('active');
            checkScroll(); // Cek ulang panah scroll saat pindah tab
        } else if (tabName === 'program') {
            tabProgram.classList.remove('hidden');
            btnProgram.classList.add('active');
            checkScroll(); 
        }
    }

    // --- 2. Logika Panah Scroll ---
    // Mencari elemen scroll bawaan dari home.ftl (.content-scroll) yang membungkus modal ini
    const scrollContainer = document.querySelector('#section-programs .content-scroll');
    const scrollHint = document.getElementById('scrollHint');

    function scrollDown() {
        if(scrollContainer) {
            scrollContainer.scrollBy({ top: 500, behavior: 'smooth' });
        }
    }

    function checkScroll() {
        if(!scrollContainer || !scrollHint) return;
        
        // Cek apakah sudah di-scroll ke bawah atau kontennya pendek
        const isAtBottom = scrollContainer.scrollHeight - scrollContainer.scrollTop <= scrollContainer.clientHeight + 100;
        
        if (scrollContainer.scrollTop > 80 || isAtBottom) {
            scrollHint.style.opacity = '0';
            scrollHint.style.pointerEvents = 'none';
        } else {
            scrollHint.style.opacity = '1';
            scrollHint.style.pointerEvents = 'auto';
        }
    }

    if(scrollContainer) {
        scrollContainer.addEventListener('scroll', checkScroll);
        // Cek saat pertama kali dimuat
        setTimeout(checkScroll, 500); 
    }
</script>