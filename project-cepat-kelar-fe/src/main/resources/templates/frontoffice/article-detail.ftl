<#-- =======================================================
     ARTICLE-DETAIL.FTL - KODE TERPADU (FIGMA UI + KOMENTAR DINAMIS)
     Murni HTML & CSS Internal, Anti Error 500
     ======================================================= -->
<style>
    /* Mengimpor font secara paksa khusus untuk fragment ini */
    @import url('https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&display=swap');
    @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

    .fg-wrapper { width: 100%; display: flex; flex-direction: column; padding: 20px 40px 60px 40px; box-sizing: border-box; }
    
    /* Tipografi & Gambar */
    .fg-title { font-family: 'Gelasio', serif; color: #3B5998; font-size: 42px; font-weight: bold; text-align: center; margin-bottom: 30px; line-height: 1.2; }
    .fg-image { width: 100%; height: 400px; object-fit: cover; border-radius: 16px; margin-bottom: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    .fg-content { font-family: 'Lato', sans-serif; color: #334155; font-size: 20px; line-height: 1.8; text-align: justify; margin-bottom: 50px; }
    .fg-content p { margin-bottom: 20px; }

    /* Area Formulir Komentar (Sesuai Figma) */
    .fg-comment-box { background-color: #E2E8F0; border-radius: 24px; padding: 40px; margin-bottom: 40px; display: flex; flex-direction: column; gap: 20px; }
    .fg-input { width: 100%; padding: 18px 24px; border-radius: 12px; border: none; font-family: 'Lato', sans-serif; font-size: 16px; color: #333; outline: none; box-sizing: border-box; }
    .fg-input::placeholder { color: #94A3B8; }
    
    .fg-textarea-wrapper { position: relative; width: 100%; }
    .fg-textarea { width: 100%; padding: 18px 24px; border-radius: 12px; border: none; height: 120px; resize: none; font-family: 'Lato', sans-serif; font-size: 16px; color: #333; outline: none; box-sizing: border-box; }
    .fg-textarea::placeholder { color: #94A3B8; text-align: center; line-height: 80px; }
    
    .fg-submit-btn { position: absolute; bottom: 15px; right: 20px; background: transparent; border: none; font-size: 24px; color: #3B5998; cursor: pointer; transition: transform 0.2s; }
    .fg-submit-btn:hover { transform: scale(1.1); }

    /* Daftar Komentar */
    .fg-comment-list { display: flex; flex-direction: column; gap: 20px; margin-top: 20px; }
    .fg-comment-item { display: flex; gap: 20px; align-items: flex-start; }
    .fg-avatar { width: 50px; height: 50px; border-radius: 50%; background-color: #3B5998; color: white; display: flex; justify-content: center; align-items: center; font-size: 20px; flex-shrink: 0; overflow: hidden; }
    .fg-comment-text-area { display: flex; flex-direction: column; gap: 4px; padding-top: 4px; }
    .fg-comment-name { font-family: 'Lato', sans-serif; font-size: 16px; font-weight: bold; color: #3B5998; }
    .fg-comment-isi { font-family: 'Lato', sans-serif; font-size: 16px; color: #475569; line-height: 1.5; }
</style>

<div class="fg-wrapper">
    
    <#-- 1. Judul & Gambar Utama -->
    <h1 class="fg-title">Memori Milik Kita</h1>
    <img src="https://picsum.photos/seed/magetan1/1080/600" alt="Memori Milik Kita" class="fg-image">

    <#-- 2. Konten Artikel -->
    <div class="fg-content">
        <p>Literasi tidak berhenti pada membaca, Di Graha Pusat Literasi, literasi bergerak lebih jauh: menjadi aksi, eksperimen, dan penciptaan makna. Melalui ruang lab komputer, pengunjung diajak melangkah dari rasa ingin tahu menuju pengalaman memahami informasi secara aktif.</p>
        
        <p>Ketika jawaban tidak selalu tersedia di rak koleksi, lab komputer menjadi ruang terbuka untuk menjelajah. Di sini, pengunjung dapat mengakses beragam sumber informasi melalui internet, menelusuri topik yang dibutuhkan, memperluas sudut pandang, dan menemukan referensi dalam berbagai bentuk—tidak hanya tulisan, tetapi juga visual dan audio digital lainnya.</p>

        <p>Suasana yang nyaman dan fasilitas yang tersedia memberi kebebasan bagi pengunjung untuk belajar sesuai ritmenya sendiri. Proses mencari informasi menjadi pengalaman yang menyenangkan: mencoba, menemukan, dan mengelola pengetahuan secara mandiri. Dari sinilah literasi berubah menjadi keterampilan yang hidup dan relevan dengan kebutuhan masa kini.</p>

        <p>Lab komputer di Graha Pusat Literasi hadir sebagai jembatan—menghubungkan pengetahuan dengan praktik, dan mengajak setiap pengunjung menjadi dari informasi ... sebuah lompatan awal untuk melangkah.</p>
    </div>

    <#-- 3. Formulir Komentar (Aktif & Bisa Diketik) -->
    <form action="/submit-comment" method="POST" class="fg-comment-box">
        <#-- Menyisipkan ID Artikel secara diam-diam agar Java tahu komentar ini untuk artikel mana -->
        <input type="hidden" name="articleId" value="${(article.id)!''}">
        
        <input type="email" name="email" placeholder="Email" class="fg-input" required>
        <input type="password" name="password" placeholder="Password" class="fg-input">
        
        <div class="fg-textarea-wrapper">
            <textarea name="comment" placeholder="Tuliskan Komentar anda disini" class="fg-textarea" required></textarea>
            <button type="submit" class="fg-submit-btn">
                <i class="fa-regular fa-paper-plane"></i>
            </button>
        </div>
    </form>

    <#-- 4. Daftar Komentar Dinamis (Anti Error 500) -->
    <div class="fg-comment-list">
        <#-- Jaring Pengaman: Jika 'comments' belum dikirim backend, jadikan array kosong agar aman -->
        <#assign safeComments = comments![]>
        
        <#if safeComments?size gt 0>
            <#-- Loop jika ada komentar dari database -->
            <#list safeComments as c>
                <div class="fg-comment-item">
                    <div class="fg-avatar">
                        <#if c.avatar?? && c.avatar?has_content>
                            <img src="${c.avatar}" style="width: 100%; height: 100%; object-fit: cover;" alt="User">
                        <#else>
                            <i class="fa-solid fa-user"></i>
                        </#if>
                    </div>
                    <div class="fg-comment-text-area">
                        <div class="fg-comment-name">${(c.userName)!"Anonim"}</div>
                        <div class="fg-comment-isi">${(c.text)!"..."}</div>
                    </div>
                </div>
            </#list>
        <#else>
            <#-- Tampilan Default jika belum ada komentar sama sekali -->
            <div class="fg-comment-item">
                <div class="fg-avatar"><i class="fa-solid fa-user"></i></div>
                <div class="fg-comment-text-area">
                    <div class="fg-comment-name">Admin Graha Pusat Literasi</div>
                    <div class="fg-comment-isi">Belum ada komentar pada artikel ini. Jadilah yang pertama memberikan pendapat Anda!</div>
                </div>
            </div>
        </#if>
    </div>

</div>