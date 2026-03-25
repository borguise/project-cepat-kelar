<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* Scoped Style khusus untuk animasi FAQ di dalam modal */
    .faq-row {
        background-color: rgba(255, 255, 255, 0.7); 
        backdrop-filter: blur(5px);
        transition: background-color 0.3s;
    }
    .faq-row:hover { background-color: rgba(255, 255, 255, 1); }
    
    /* Animasi Ikon Morphing (+ ke -) */
    .faq-icon-box { width: 30px; height: 30px; position: relative; display: flex; justify-content: center; align-items: center; }
    .faq-icon-box::before, .faq-icon-box::after { content: ''; position: absolute; background-color: #3B5998; border-radius: 2px; transition: all 300ms ease; }
    .faq-icon-box::before { width: 20px; height: 3px; }
    .faq-icon-box::after { width: 3px; height: 20px; }
    .active .faq-icon-box::after { transform: rotate(90deg); opacity: 0; }

    /* Animasi Buka-Tutup Lembut */
    .faq-body { display: grid; grid-template-rows: 0fr; transition: all 400ms cubic-bezier(0.4, 0, 0.2, 1); }
    .active + .faq-body { grid-template-rows: 1fr; margin-bottom: 24px; }
    .faq-content { overflow: hidden; }
</style>

<div class="flex flex-col relative min-h-full">
    
    <div class="text-center mb-10 mt-4">
        <h2 class="text-4xl font-black text-[#1a1a1a] uppercase tracking-wide font-['Gelasio']">${mainTitle!"Sorotan & FAQ"}</h2>
        <p class="text-lg text-gray-600 mt-3 font-['Gelasio'] max-w-2xl mx-auto">${subTitle!"Pertanyaanmu penting, dan kami siap menjawabnya di sini."}</p>
    </div>

    <div class="w-full max-w-3xl mx-auto flex-grow">
        <#if faqs??>
            <#list faqs as faq>
                <div class="faq-row rounded-xl p-5 flex items-center gap-5 cursor-pointer mb-3 border border-gray-200 shadow-sm" onclick="this.classList.toggle('active')">
                    <div class="faq-icon-box shrink-0"></div>
                    <h3 class="font-['Gelasio'] text-xl font-bold text-[#334155] flex-1">${faq.question}</h3>
                </div>
                <div class="faq-body">
                    <div class="faq-content px-5">
                        <p class="text-[#475569] text-lg leading-relaxed italic border-l-4 border-[#3B5998] pl-5 py-2">${faq.answer}</p>
                    </div>
                </div>
            </#list>
        <#else>
            <div class="faq-row rounded-xl p-5 flex items-center gap-5 cursor-pointer mb-3 border border-gray-200 shadow-sm" onclick="this.classList.toggle('active')">
                <div class="faq-icon-box shrink-0"></div>
                <h3 class="font-['Gelasio'] text-xl font-bold text-[#334155] flex-1">Apa saja program literasi unggulan minggu ini?</h3>
            </div>
            <div class="faq-body">
                <div class="faq-content px-5">
                    <p class="text-[#475569] text-lg leading-relaxed italic border-l-4 border-[#3B5998] pl-5 py-2">Minggu ini kami mengadakan diskusi Sastra Jawa & pertunjukan musik Tongkling. Pendaftaran gratis dapat dilakukan di meja resepsionis Lantai 1.</p>
                </div>
            </div>

            <div class="faq-row rounded-xl p-5 flex items-center gap-5 cursor-pointer mb-3 border border-gray-200 shadow-sm" onclick="this.classList.toggle('active')">
                <div class="faq-icon-box shrink-0"></div>
                <h3 class="font-['Gelasio'] text-xl font-bold text-[#334155] flex-1">Bagaimana cara meminjam buku di Graha Pusat Literasi?</h3>
            </div>
            <div class="faq-body">
                <div class="faq-content px-5">
                    <p class="text-[#475569] text-lg leading-relaxed italic border-l-4 border-[#3B5998] pl-5 py-2">Cukup mendaftar sebagai anggota menggunakan KTP atau Kartu Pelajar. Prosesnya cepat dan Anda langsung bisa meminjam maksimal 3 buku.</p>
                </div>
            </div>
        </#if>
    </div>

    <div class="mt-12 text-center border-t-2 border-[#3B5998]/30 pt-8 pb-4">
        <p class="text-xl font-bold text-gray-700 font-['Gelasio'] mb-6">${footerDesc!"Masih butuh bantuan atau informasi tambahan?"}</p>
        <div class="flex justify-center gap-10">
            <a href="${whatsappLink!"#"}" class="text-5xl text-[#25D366] hover:scale-110 hover:-translate-y-1 transition-all"><i class="fab fa-whatsapp"></i></a>
            <a href="${instagramLink!"#"}" class="text-5xl text-[#E1306C] hover:scale-110 hover:-translate-y-1 transition-all"><i class="fab fa-instagram"></i></a>
        </div>
    </div>

</div>