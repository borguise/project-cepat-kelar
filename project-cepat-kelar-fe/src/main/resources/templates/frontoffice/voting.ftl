<#-- =======================================================
     VOTING.FTL - FINAL ULTIMATE VERSION (30+ ITEMS READY)
     Fitur: Sticky Header, Grid 2x3, Anti-Double Scroll, & Snap
     ======================================================= -->

<style>
    /* 1. Kontainer Utama */
    .vote-main-container {
        width: 100%;
        height: 100%;
        background-color: #FAF6ED; 
        position: relative;
        /* Mengaktifkan scroll internal fragment secara paksa */
        overflow-y: auto !important; 
        scrollbar-width: none; 
        display: block;
        /* Memastikan scroll terasa natural di layar sentuh */
        -webkit-overflow-scrolling: touch;
    }
    .vote-main-container::-webkit-scrollbar { display: none; }

    /* 2. Latar Belakang Batik Penuh */
    .vote-batik-layer {
        position: absolute;
        top: 0; left: 0; right: 0;
        min-height: 100%; 
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}');
        background-size: 600px;
        opacity: 0.12;
        mix-blend-mode: multiply;
        pointer-events: none; 
        z-index: 1;
    }

    /* 3. STICKY HEADER SECTION */
    .vote-sticky-header {
        position: sticky;
        top: 0;
        width: 100%;
        background-color: rgba(250, 246, 237, 0.95); 
        backdrop-filter: blur(10px); 
        padding: 60px 40px 30px 40px;
        text-align: center;
        z-index: 100; 
        border-bottom: 1px solid rgba(0,0,0,0.05);
    }

    .vote-main-title {
        font-family: 'Gelasio', serif;
        color: #1F1F1F;
        font-size: 52px;
        font-weight: bold;
        margin: 0 0 15px 0;
    }
    .vote-main-desc {
        font-family: 'Lato', sans-serif;
        color: #5A6A5A;
        font-size: 26px;
        line-height: 1.4;
        max-width: 750px;
        margin: 0 auto;
    }

    /* 4. KONTAINER PUTIH UTAMA */
    .vote-white-wrapper {
        position: relative;
        z-index: 10;
        background: #FFFFFF;
        border-radius: 60px; 
        margin: 40px 50px 120px 50px;
        padding: 50px 40px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.03);
    }

    /* --- GRID SYSTEM DENGAN SCROLL SNAP --- */
    .vote-grid-layout {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 30px;
        width: 100%;
        /* Fitur Tahan Banting: Scroll Snap Type */
        scroll-snap-type: y proximity;
    }

    /* --- KARTU VOTING --- */
    .vote-item-card {
        background: white;
        border-radius: 35px;
        border: 2px solid #E5E7EB;
        overflow: hidden;
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        box-shadow: 0 8px 20px rgba(0,0,0,0.02);
        position: relative;
        /* Menyeimbangkan posisi kartu saat scroll berhenti */
        scroll-snap-align: start;
    }
    
    .vote-item-card.selected-active {
        border-color: #EF4444;
        border-width: 4px;
        transform: translateY(-8px);
        box-shadow: 0 15px 30px rgba(239, 68, 68, 0.12);
    }

    .vote-card-img-box {
        width: 100%;
        height: 330px; 
        background-color: #F8FAFC;
        display: flex;
        justify-content: center;
        align-items: center;
        border-bottom: 1.5px solid #E5E7EB;
    }
    .vote-card-img-box img { width: 100%; height: 100%; object-fit: cover; }
    .vote-icon-placeholder { font-size: 110px; color: #cbd5e1; }

    /* FOOTER KARTU */
    .vote-card-details {
        padding: 20px 22px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #fff;
        min-height: 90px;
    }
    .vote-name {
        font-family: 'Inter', sans-serif;
        font-size: 30px;
        font-weight: 600;
        color: #1F1F1F;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 65%;
    }

    .vote-count-num {
        font-family: 'Inter', sans-serif;
        font-size: 30px;
        font-weight: 600;
        color: #1F1F1F;
        transition: color 0.3s;
    }
    .counter-active { color: #EF4444 !important; }

    .vote-heart-action {
        font-size: 40px;
        color: #1F1F1F;
        cursor: pointer;
        transition: transform 0.2s ease;
    }
    .vote-heart-action.fas { color: #EF4444 !important; transform: scale(1.1); }
</style>

<div class="vote-main-container">
    <div class="vote-batik-layer"></div>

    <header class="vote-sticky-header">
        <h1 class="vote-main-title">Ayo berikan dukunganmu!</h1>
        <p class="vote-main-desc">Berikan suara untuk karya terbaik menurutmu dan jadilah saksi perjalanan juara desain cover Junior Writerpreneurship tahun 2025</p>
    </header>

    <div class="vote-white-wrapper">
        <div class="vote-grid-layout">
            <#-- LOOPING DINAMIS DARI DATABASE -->
            <#if participants?? && (participants?size > 0)>
                <#list participants as p>
                    <div class="vote-item-card" id="vCardItem-${p.id}">
                        <div class="vote-card-img-box">
                            <#if p.coverImage?? && p.coverImage?has_content>
                                <img src="${p.coverImage}" alt="${p.name}">
                            <#else>
                                <i class="fas fa-user vote-icon-placeholder"></i>
                            </#if>
                        </div>
                        <div class="vote-card-details">
                            <span class="vote-name" title="${p.name}">${p.name}</span>
                            <div class="flex items-center gap-3">
                                <span class="vote-count-num" id="vNumDisplay-${p.id}">${p.voteCount!0}</span>
                                <i class="far fa-heart vote-heart-action" onclick="executeVoteAction('${p.id}', this)"></i>
                            </div>
                        </div>
                    </div>
                </#list>
            <#else>
                <#-- MOCK DATA 12 ITEM (Test Ketahanan 30+ Items) -->
                <#list 1..12 as i>
                    <div class="vote-item-card" id="vCardItem-dummy${i}">
                        <div class="vote-card-img-box">
                            <i class="fas fa-user vote-icon-placeholder"></i>
                        </div>
                        <div class="vote-card-details">
                            <span class="vote-name">Peserta ${i}</span>
                            <div class="flex items-center gap-3">
                                <span class="vote-count-num" id="vNumDisplay-dummy${i}">12</span>
                                <i class="far fa-heart vote-heart-action" onclick="executeVoteAction('dummy${i}', this)"></i>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>
        </div>
    </div>
</div>

<script>
    // Menyimpan data asli DB agar visual akurat
    const initialVoteData = {
        <#if participants?? && participants?size gt 0>
            <#list participants as p>
                "${p.id}": ${p.voteCount!0}<#if p?has_next>,</#if>
            </#list>
        <#else>
            <#list 1..12 as i>"dummy${i}": 12<#if i != 12>,</#if></#list>
        </#if>
    };

    let userVotedId = null;

    function executeVoteAction(id, element) {
        if (userVotedId === id) return;

        // 1. Reset kartu sebelumnya
        if (userVotedId !== null) {
            const oldCard = document.getElementById('vCardItem-' + userVotedId);
            const oldNum = document.getElementById('vNumDisplay-' + userVotedId);
            if(oldCard) {
                oldCard.classList.remove('selected-active');
                const oldHeart = oldCard.querySelector('.vote-heart-action');
                if(oldHeart) { 
                    oldHeart.classList.replace('fas', 'far');
                }
                if(oldNum) { 
                    oldNum.classList.remove('counter-active');
                    oldNum.innerText = initialVoteData[userVotedId] || 0;
                }
            }
        }

        // 2. Aktifkan kartu baru
        const newCard = document.getElementById('vCardItem-' + id);
        const newNum = document.getElementById('vNumDisplay-' + id);
        
        if(newCard && newNum) {
            newCard.classList.add('selected-active');
            element.classList.replace('far', 'fas');
            newNum.classList.add('counter-active');
            
            // Visual +1
            const baseValue = initialVoteData[id] || 0;
            newNum.innerText = baseValue + 1;
            
            userVotedId = id;
            console.log("Vote recorded for ID: " + id);
        }
    }
</script>