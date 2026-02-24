<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle!"Voting - Junior Writerpreneurship 2025"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@400;700&family=Lato:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; padding: 0; height: 100vh; width: 100vw; overflow: hidden; display: flex; justify-content: center; align-items: center; }

        /* KANVAS UTAMA: 864x1536 */
        #voting-canvas {
            width: 864px; height: 1536px;
            background-color: #F5F0DB; /* Krem Solid */
            position: relative; overflow: hidden;
            display: flex; flex-direction: column;
            box-shadow: 0 0 120px rgba(0,0,0,0.6);
            transform-origin: center center;
        }

        /* AREA GULIR */
        .content-scroll {
            flex: 1; overflow-y: auto;
            padding: 0 70px; 
            z-index: 10;
            scrollbar-width: none;
            display: flex; flex-direction: column; align-items: center;
        }
        .content-scroll::-webkit-scrollbar { display: none; }

        /* HEADER SECTION */
        .header-voting {
            position: relative; width: 100%; padding-top: 130px; text-align: center; margin-bottom: 60px;
        }
        .close-btn {
            position: absolute; top: 40px; right: 0;
            font-size: 55px; color: #1F1F1F;
            cursor: pointer; font-family: 'Inter', sans-serif;
        }

        .title-voting { font-family: 'Gelasio', serif; color: #1F1F1F; font-size: 56px; font-weight: bold; margin-bottom: 30px; }
        .desc-voting { font-family: 'Lato', sans-serif; color: #5A6A5A; font-size: 32px; font-weight: 500; line-height: 1.5; max-width: 700px; margin: 0 auto; }

        /* KONTAINER PUTIH UTAMA */
        .white-container {
            width: 100%;
            background-color: #FFFFFF;
            border-radius: 50px; 
            padding: 55px 40px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.04);
            margin-bottom: 120px;
        }

        .voting-grid {
            display: grid; grid-template-columns: 1fr 1fr; gap: 35px;
        }

        /* KARTU VOTING */
        .vote-card {
            background: white; border-radius: 28px;
            border: 2px solid #E5E7EB; overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .vote-card.selected { border: 4px solid #EF4444; transform: translateY(-10px); box-shadow: 0 20px 40px rgba(239, 68, 68, 0.12); }

        .card-image-area {
            width: 100%; height: 340px;
            background-color: #F8FAFC; 
            display: flex; justify-content: center; align-items: center;
            border-bottom: 2px solid #E5E7EB;
        }
        .cover-img { width: 100%; height: 100%; object-fit: cover; }
        .placeholder-icon { font-size: 130px; color: #334155; }

        .card-info {
            padding: 25px 20px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .name-text { font-family: 'Inter', sans-serif; font-size: 34px; font-weight: 600; color: #1F1F1F; }
        
        .vote-action { display: flex; align-items: center; gap: 12px; }
        .count-text { font-family: 'Inter', sans-serif; font-size: 34px; font-weight: 600; color: #1F1F1F; transition: color 0.3s; }
        .count-text.active { color: #EF4444; }
        
        .heart-btn { font-size: 42px; color: #1F1F1F; cursor: pointer; transition: all 0.2s ease; }
        .heart-btn.active { color: #EF4444; transform: scale(1.1); }
    </style>
</head>
<body>

    <div id="voting-canvas">
        <div class="content-scroll">
            
            <header class="header-voting">
                <div class="close-btn" onclick="window.history.back()">X</div>
                <h1 class="title-voting">${mainTitle!"Ayo berikan dukunganmu!"}</h1>
                <p class="desc-voting">
                    ${subTitle!"Berikan suara untuk karya terbaik menurutmu dan jadilah saksi perjalanan juara desain cover Junior Writerpreneurship tahun 2025"}
                </p>
            </header>

            <div class="white-container">
                <div class="voting-grid">
                    
                    <#if participants??>
                        <#list participants as p>
                            <div class="vote-card" id="card-${p.id}">
                                <div class="card-image-area">
                                    <#if p.coverImage??>
                                        <img src="${p.coverImage}" class="cover-img" alt="Cover ${p.name}">
                                    <#else>
                                        <i class="fas fa-user placeholder-icon"></i>
                                    </#if>
                                </div>
                                <div class="card-info">
                                    <span class="name-text">${p.name}</span>
                                    <div class="vote-action">
                                        <span class="count-text" id="count-${p.id}">${p.voteCount!0}</span>
                                        <i class="far fa-heart heart-btn" onclick="processVote('${p.id}', this)"></i>
                                    </div>
                                </div>
                            </div>
                        </#list>
                    </#if>

                </div>
            </div>

        </div>
    </div>

    <script>
        // Inisialisasi data suara awal dari backend
        const initialVotes = {
            <#if participants??>
                <#list participants as p>
                    "${p.id}": ${p.voteCount!0}<#if p?has_next>,</#if>
                </#list>
            </#if>
        };

        let currentSelectedId = null;

        function processVote(id, element) {
            if (currentSelectedId === id) return;

            // 1. Reset Pilihan Sebelumnya (Berubah Pikiran)
            if (currentSelectedId !== null) {
                const prevCard = document.getElementById('card-' + currentSelectedId);
                const prevCountText = document.getElementById('count-' + currentSelectedId);
                const prevHeart = prevCard.querySelector('.heart-btn');

                prevCard.classList.remove('selected');
                prevCountText.classList.remove('active');
                prevHeart.classList.remove('fas', 'active');
                prevHeart.classList.add('far');
                
                prevCountText.innerText = initialVotes[currentSelectedId];
            }

            // 2. Aktifkan Pilihan Baru (Increment)
            const currentCard = document.getElementById('card-' + id);
            const currentCountText = document.getElementById('count-' + id);

            currentCard.classList.add('selected');
            currentCountText.classList.add('active');
            element.classList.remove('far');
            element.classList.add('fas', 'active');
            
            // Tambahkan suara secara visual
            currentCountText.innerText = initialVotes[id] + 1;

            currentSelectedId = id;

            // Kirim data ke backend via AJAX jika diperlukan
            console.log("Voting tercatat untuk ID: " + id);
        }

        function scaleCanvas() {
            const canvas = document.getElementById('voting-canvas');
            const scale = Math.min(window.innerWidth / 864, window.innerHeight / 1536);
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>