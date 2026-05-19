<#-- activities.ftl - FIX LINK & FULL CONTENT 8 ITEMS -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">

<style>
    .activities-wrapper { 
        background-color: white; 
        /* PERBAIKAN: Jarak atas disesuaikan menjadi 80px agar elemen atas bernapas lega dan tidak sesak */
        padding: 80px 20px 40px 20px; 
        font-family: 'Inter', sans-serif; 
        min-height: 100%; 
        display: flex; 
        flex-direction: column; 
        align-items: center;
    }
    
    /* PERBAIKAN UTAMA: Perbaikan line-height agar teks tidak terpotong & max-width sebagai safe zone dari tombol silang */
    .main-title { 
        font-size: 32px; 
        font-weight: 900; 
        color: #000; 
        text-align: center; 
        margin-bottom: 35px; 
        line-height: 1.4; /* Mengatasi teks terpotong di bagian bawah */
        max-width: 700px; /* Mencegah teks melebar terlalu ke kanan-kiri mendekati tombol silang */
        padding: 0 40px; 
        margin-left: auto; 
        margin-right: auto;
    }
    
    .tab-container { display: flex; justify-content: center; margin-bottom: 40px; }
    .tab-box { display: flex; background: #3B5998; border-radius: 12px; padding: 5px; }
    .tab-item { width: 140px; height: 40px; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px; cursor: pointer; border-radius: 8px; transition: 0.3s; }
    .tab-item.active { background: rgba(255,255,255,0.3); font-weight: bold; }

    .content-section { width: 100%; max-width: 750px; display: flex; flex-direction: column; }
    .unit { display: flex; align-items: center; gap: 30px; margin: 45px 0; width: 100%; }
    .unit.reverse { flex-direction: row-reverse; }
    
    .unit-text { flex: 1; text-align: center; display: flex; flex-direction: column; align-items: center; }
    .unit-title { font-size: 26px; font-weight: 900; margin-bottom: 10px; color: #000; }
    .unit-desc { font-size: 19px; font-weight: 600; line-height: 1.4; color: #1a1a1a; margin-bottom: 10px; }
    .unit-link { font-size: 19px; color: #3B5998; font-weight: 800; text-decoration: underline; cursor: pointer; }
    
    .unit-img { width: 240px; height: 300px; border-radius: 40px; object-fit: cover; background: #f9f6e5; flex-shrink: 0; }
    
    .sep { border-top: 2px solid #6B8A7A; width: 100%; margin: 10px 0; opacity: 0.3; }
    .hidden { display: none !important; }
</style>

<div class="activities-wrapper">
    <header>
        <h1 class="main-title" id="tab-heading">Layanan - layanan untuk pengunjung<br>Graha Pusat Literasi Kabupaten Magetan</h1>
        <div class="tab-container">
            <div class="tab-box">
                <div id="btn-layanan" class="tab-item active" onclick="switchContent('layanan')">Layanan</div>
                <div id="btn-kegiatan" class="tab-item" onclick="switchContent('kegiatan')">Kegiatan</div>
            </div>
        </div>
    </header>

    <#-- SECTION LAYANAN -->
    <div id="content-layanan" class="content-section">
        <#list 1..8 as i>
            <div class="unit ${(i % 2 == 0)?string('reverse', '')}">
                <#if i==1>
                    <img src="${basePath}/umum.png" class="unit-img">
                    <div class="unit-text">
                        <h2 class="unit-title">Layanan Baca Ditempat</h2>
                        <p class="unit-desc">Ruang tenang untuk menikmati bacaan dan meluangkan waktu bersama buku.</p>
                        <a href="#" class="unit-link">Baca ceritanya di sini.</a>
                    </div>
                <#elseif i==2>
                    <img src="${basePath}/anak.png" class="unit-img">
                    <div class="unit-text">
                        <h2 class="unit-title">Layanan Ruang Baca Anak</h2>
                        <p class="unit-desc">Ruang ramah anak untuk membaca, bermain, dan mengenal literasi sejak dini.</p>
                        <a href="#" class="unit-link">Jelajahi selengkapnya.</a>
                    </div>
                <#elseif i==3>
                    <img src="${basePath}/berkelompok.png" class="unit-img">
                    <div class="unit-text">
                        <h2 class="unit-title">Layanan Kunjungan Berkelompok</h2>
                        <p class="unit-desc">Pengalaman literasi yang lebih seru melalui kunjungan dan kebersamaan.</p>
                        <a href="#" class="unit-link">Baca ceritanya di sini.</a>
                    </div>
                <#elseif i==4>
                    <img src="${basePath}/member.png" class="unit-img">
                    <div class="unit-text">
                        <h2 class="unit-title">Layanan Pendaftaran Anggota</h2>
                        <p class="unit-desc">Langkah awal untuk menikmati layanan dan koleksi perpustakaan secara lebih luas.</p>
                        <a href="#" class="unit-link">Jelajahi selengkapnya.</a>
                    </div>
                <#elseif i==5>
                    <img src="${basePath}/sirkulasi.png" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Layanan Sirkulasi</h2><p class="unit-desc">Proses peminjaman dan pengembalian buku yang mudah.</p><a href="#" class="unit-link">Baca selengkapnya.</a></div>
                <#elseif i==6>
                    <img src="${basePath}/komputer.png" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Lab Komputer</h2><p class="unit-desc">Akses informasi digital dan riset untuk pengunjung.</p><a href="#" class="unit-link">Jelajahi.</a></div>
                <#elseif i==7>
                    <img src="${basePath}/rack.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Layanan Loker</h2><p class="unit-desc">Perhatian khusus untuk Sahabat Literasi.</p><a href="#" class="unit-link">Lihat fasilitas.</a></div>
                <#else>
                    <img src="${basePath}/bangunan-copy-0.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Pemanfaatan Ruang</h2><p class="unit-desc">Area serbaguna untuk diskusi dan kegiatan komunitas.</p><a href="#" class="unit-link">Jelajahi.</a></div>
                </#if>
            </div>
            <#if i != 8><div class="sep"></div></#if>
        </#list>
    </div>

    <#-- SECTION KEGIATAN -->
    <div id="content-kegiatan" class="content-section hidden">
        <#list 1..8 as i>
            <div class="unit ${(i % 2 == 0)?string('reverse', '')}">
                <#if i==1>
                    <img src="${basePath}/junior.png" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Junior Writerpreneurship</h2><p class="unit-desc">Ajang mengarang tulisan bagi siswa sekolah menengah.</p></div>
                <#elseif i==2>
                    <img src="${basePath}/duta.png" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Seleksi Duta Baca</h2><p class="unit-desc">Pemilihan ikon literasi untuk memotivasi generasi muda.</p></div>
                <#elseif i==3>
                    <img src="${basePath}/puisi.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Kepenulisan Puisi</h2><p class="unit-desc">Wadah ekspresi melalui rangkaian kata indah.</p></div>
                <#elseif i==4>
                    <img src="${basePath}/peer.png" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Peer Learning Meeting</h2><p class="unit-desc">Berbagi ilmu dan pengalaman antar pengelola perpustakaan.</p></div>
                <#elseif i==5>
                    <img src="${basePath}/kemah.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Camp Literasi</h2><p class="unit-desc">Keseruan belajar di alam terbuka.</p></div>
                <#elseif i==6>
                    <img src="${basePath}/bazar.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Bazaar TPBIS</h2><p class="unit-desc">Pameran produk literasi masyarakat lokal.</p></div>
                <#elseif i==7>
                    <img src="${basePath}/bedahbuku.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Bedah Buku</h2><p class="unit-desc">Diskusi mendalam bersama penulis buku favorit.</p></div>
                <#else>
                    <img src="${basePath}/sosialisasi.jpg" class="unit-img">
                    <div class="unit-text"><h2 class="unit-title">Sosialisasi Budaya Baca</h2><p class="unit-desc">Mengenalkan pentingnya literasi ke masyarakat luas.</p></div>
                </#if>
            </div>
            <#if i != 8><div class="sep"></div></#if>
        </#list>
    </div>

    <div style="height: 80px;"></div>
</div>

<script>
    function switchContent(target) {
        const cLayanan = document.getElementById('content-layanan');
        const cKegiatan = document.getElementById('content-kegiatan');
        const bLayanan = document.getElementById('btn-layanan');
        const bKegiatan = document.getElementById('btn-kegiatan');
        const heading = document.getElementById('tab-heading');

        if (target === 'layanan') {
            cLayanan.classList.remove('hidden');
            cKegiatan.classList.add('hidden');
            bLayanan.classList.add('active');
            bKegiatan.classList.remove('active');
            heading.innerHTML = "Layanan - layanan untuk pengunjung<br>Graha Pusat Literasi Kabupaten Magetan";
        } else {
            cKegiatan.classList.remove('hidden');
            cLayanan.classList.add('hidden');
            bKegiatan.classList.add('active');
            bLayanan.classList.remove('active');
            heading.innerHTML = "Program - program unggulan<br>Graha Pusat Literasi Kabupaten Magetan";
        }
        
        const scrollBox = document.querySelector('.content-scroll');
        if (scrollBox) scrollBox.scrollTop = 0;
    }
</script>