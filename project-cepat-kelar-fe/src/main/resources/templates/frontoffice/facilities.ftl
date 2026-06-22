<#-- =======================================================
     FASILITAS.FTL - KOMPONEN OVERLAY MURNI (FRAGMENT)
     Fitur: Carousel Interaktif, Image Path Fixed
     ======================================================= -->

<style>
    /* ========================================================
       KODE CSS MURNI UNTUK KOMPONEN FASILITAS
       ======================================================== */
    .fas-container {
        width: 100%; 
        min-height: 100%; 
        background-color: #f7f0cb; 
        position: relative;
        display: flex; 
        flex-direction: column;
        overflow: hidden; 
    }

    /* Lapisan Batik yang menutupi seluruh container */
    .fas-batik-bg {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
        background-size: cover;
        opacity: 0.4; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    .fas-content-wrapper {
        flex: 1; display: flex; flex-direction: column;
        justify-content: space-between; align-items: center;
        padding: 80px 40px; 
        z-index: 10;
    }

    /* --- HEADER --- */
    .fas-header-section { text-align: center; margin-bottom: 20px; }
    .fas-title { font-family: 'Gelasio', serif; color: #334155; font-size: 85px; font-weight: bold; margin-bottom: 10px; line-height: 1.1;}
    .fas-subtitle { font-family: 'Gelasio', serif; color: #475569; font-size: 38px; font-weight: bold; }

    /* --- CAROUSEL --- */
    .fas-carousel-outer { 
        position: relative; 
        width: 100%; max-width: 800px; 
        display: flex; align-items: center; justify-content: center; 
        margin: auto 0; 
    }

    .fas-carousel-frame {
        width: 720px; 
        height: 850px; 
        background-color: white;
        border-radius: 60px;
        border: 2px solid #000; 
        overflow: hidden;
        box-shadow: 0 20px 50px rgba(0,0,0,0.1);
    }

    .fas-carousel-track {
        display: flex; overflow-x: auto; scroll-snap-type: x mandatory;
        scrollbar-width: none; height: 100%; scroll-behavior: smooth;
    }
    .fas-carousel-track::-webkit-scrollbar { display: none; }

    .fas-carousel-slide {
        min-width: 100%; height: 100%; scroll-snap-align: start;
        display: flex; flex-direction: column; align-items: center; justify-content: center;
        padding: 40px 60px; text-align: center; box-sizing: border-box; 
    }

    .fas-slide-judul { font-family: 'Gelasio', serif; font-size: 48px; color: #000; margin-bottom: 25px; font-weight: bold; }
    .fas-slide-img { width: 100%; height: 450px; border-radius: 30px; object-fit: cover; margin-bottom: 35px; border: 1px solid #ddd; background-color: #e2e8f0; }
    .fas-slide-caption { font-family: 'Lato', sans-serif; font-size: 30px; color: #334155; line-height: 1.5; }

    /* NAVIGASI PANAH */
    .fas-nav-arrow {
        position: absolute; top: 50%; transform: translateY(-50%);
        width: 80px; height: 80px;
        background-color: rgba(255, 255, 255, 0.9);
        border: 2px solid #334155; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 32px; color: #334155; cursor: pointer;
        z-index: 20; transition: all 0.2s ease;
    }
    .fas-nav-arrow:hover { background-color: #334155; color: white; }
    .fas-prev-arrow { left: -15px; }
    .fas-next-arrow { right: -15px; }

    /* --- FOOTER --- */
    .fas-footer-text {
        width: 100%; max-width: 780px; text-align: center;
        font-family: 'Lato', sans-serif; font-size: 26px; color: #64748b; 
        line-height: 1.6; font-style: italic; margin-top: 20px;
    }
</style>

<div class="fas-container">
    
    <div class="fas-batik-bg"></div>

    <div class="fas-content-wrapper">
        
        <header class="fas-header-section">
            <h1 class="fas-title">${mainHeader!"Fasilitas"}</h1>
            <p class="fas-subtitle">${subHeader!"Satu ruang, banyak inspirasi"}</p>
        </header>

        <div class="fas-carousel-outer">
            <div class="fas-nav-arrow fas-prev-arrow" onclick="fasManualMove(-1)"><i class="fas fa-chevron-left"></i></div>
            <div class="fas-nav-arrow fas-next-arrow" onclick="fasManualMove(1)"><i class="fas fa-chevron-right"></i></div>

            <div class="fas-carousel-frame">
                <div class="fas-carousel-track" id="fasCarouselTrack">
                    
                    <#if facilities?? && facilities?size gt 0>
                        <#list facilities as f>
                            <div class="fas-carousel-slide">
                                <h2 class="fas-slide-judul">${f.title}</h2>
                                <img src="${f.imagePath}" class="fas-slide-img" alt="${f.title}" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=Gambar+Tidak+Tersedia'">
                                <p class="fas-slide-caption">${f.caption}</p>
                            </div>
                        </#list>
                    <#else>
                        <#-- Konten Fallback/Statis (Path Gambar Sudah Diperbaiki) -->
                        <div class="fas-carousel-slide">
                            <h2 class="fas-slide-judul">Ruang Baca Okky</h2>
                            <img src="/images/frontoffice/ruangokky.png" class="fas-slide-img" alt="Ruang Baca Okky" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=Ruang+Baca+Okky'">
                            <p class="fas-slide-caption">Sebuah ruang yang didedikasi Okky Madasari berisikan koleksi pilihannya</p>
                        </div>
                        <div class="fas-carousel-slide">
                            <h2 class="fas-slide-judul">Ruang Baca Umum</h2>
                            <img src="/images/frontoffice/rbu.png" class="fas-slide-img" alt="Ruang Baca Umum" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=Ruang+Baca+Umum'">
                            <p class="fas-slide-caption">Sebuah aula bagi pengunjung untuk memanfaatkan koleksi dengan nyaman dan tenang.</p>
                        </div>
                        <div class="fas-carousel-slide">
                            <h2 class="fas-slide-judul">Ruang Baca Anak</h2>
                            <img src="/images/frontoffice/anak.jpeg" class="fas-slide-img" alt="Ruang Baca Anak" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=Ruang+Baca+Anak'">
                            <p class="fas-slide-caption">Sebuah ruangan yang disediakan untuk anak-anak bermain dan berliterasi dengan nyaman</p>
                        </div>
                        <div class="fas-carousel-slide">
                            <h2 class="fas-slide-judul">Ruang Pertemuan</h2>
                            <img src="/images/frontoffice/ruangpertemuan.png" class="fas-slide-img" alt="Ruang Pertemuan" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=Ruang+Pertemuan'">
                            <p class="fas-slide-caption">Sebuah aula dengan fasilitas lengkap untuk kegiatan dengan kapasitas 300 orang.</p>
                        </div>
                        <div class="fas-carousel-slide">
                            <h2 class="fas-slide-judul">Ruang Komputer</h2>
                            <img src="/images/frontoffice/computer.png" class="fas-slide-img" alt="Ruang Komputer" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=Ruang+Komputer'">
                            <p class="fas-slide-caption">Sebuah ruang khusus dengan unit komputer dan internet untuk digunakan pengunjung.</p>
                        </div>
                        <div class="fas-carousel-slide">
                            <h2 class="fas-slide-judul">Loker</h2>
                            <img src="/images/frontoffice/loker.png" class="fas-slide-img" alt="loker" onerror="this.src='https://placehold.co/800x600/e2e8f0/64748b?text=loker'">
                            <p class="fas-slide-caption">Tempat aman untuk menyimpan barang kesayangan selama di perpustakaan</p>
                        </div>
                    </#if>
                    
                </div>
            </div>
        </div>

        <footer class="fas-footer-text">
            "Perpustakaan bukan hanya tentang buku, tapi tentang bagaimana menciptakan ide menjadi kenyataan. Sebuah wadah bagi pribadi yang ingin terus berkembang."
        </footer>
    </div>
</div>

<script>
    const fasTrack = document.getElementById('fasCarouselTrack');
    const fasSlides = document.querySelectorAll('.fas-carousel-slide');
    let fasCurrentIndex = 0;
    const fasTotalSlides = fasSlides.length;
    let fasSlideInterval;

    function fasManualMove(direction) {
        clearInterval(fasSlideInterval);
        fasCurrentIndex += direction;
        
        if (fasCurrentIndex >= fasTotalSlides) fasCurrentIndex = 0;
        if (fasCurrentIndex < 0) fasCurrentIndex = fasTotalSlides - 1;
        
        fasUpdatePosition();
        fasStartAutoSlide();
    }

    function fasUpdatePosition() {
        if(fasTrack) {
            const width = fasTrack.offsetWidth;
            fasTrack.scrollTo({ left: fasCurrentIndex * width, behavior: 'smooth' });
        }
    }

    function fasStartAutoSlide() {
        fasSlideInterval = setInterval(() => {
            if (fasTotalSlides > 1) {
                fasCurrentIndex = (fasCurrentIndex + 1) % fasTotalSlides;
                fasUpdatePosition();
            }
        }, 6000);
    }

    if(fasTotalSlides > 1) {
        fasStartAutoSlide();
    }
</script>