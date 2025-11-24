# GitHub Actions Scheduling Pattern

## Overview

Dokumentasi ini menjelaskan pola scheduling yang digunakan untuk automated updates pada blog post dan product metrics. Sistem ini dirancang untuk menciptakan update pattern yang **natural, unpredictable, dan human-like**.

---

## Revisi Terbaru (v2.0)

### Perubahan dari Pola Sebelumnya

**Pola Lama (v1.0) - Fixed Schedule:**
```yaml
schedule:
  # POST: Monday + Thursday (4 fixed slots)
  - cron: '45 23 * * 0'  # Sunday 23:45 UTC
  - cron: '30 1 * * 1'   # Monday 01:30 UTC
  - cron: '15 2 * * 4'   # Thursday 02:15 UTC
  - cron: '0 4 * * 4'    # Thursday 04:00 UTC

  # PRODUCT: Tuesday + Friday (4 fixed slots)
  - cron: '15 2 * * 2'   # Tuesday 02:15 UTC
  - cron: '45 4 * * 2'   # Tuesday 04:45 UTC
  - cron: '30 5 * * 5'   # Friday 05:30 UTC
  - cron: '0 7 * * 5'    # Friday 07:00 UTC
```

**Masalah:**
- ❌ Hari tetap sama setiap minggu (predictable)
- ❌ Jam dan menit berulang setiap minggu
- ❌ Tidak ada filter jam tidur
- ❌ Random delay hanya menggeser waktu, tidak mengubah pola

---

**Pola Baru (v2.0) - Time Window + Escalating Probability:**
```yaml
schedule:
  # Check every 2 hours (12 checks per day)
  - cron: '0 */2 * * *'
```

**Keunggulan:**
- ✅ Dynamic scheduling (tidak ada fixed pattern)
- ✅ Time window filter (skip jam tidur 22:00-05:59 WIB)
- ✅ Escalating probability (makin lama makin urgent)
- ✅ Unique timestamps (random delay 0-59m + 0-59s)
- ✅ Self-adjusting berdasarkan last update

---

## Arsitektur Pola v2.0

### 1. Scheduling Frequency

```yaml
on:
  schedule:
    - cron: '0 */2 * * *'  # Every 2 hours, 12 checks per day
  workflow_dispatch:       # Manual trigger available
```

**Karakteristik:**
- Workflow dijalankan setiap 2 jam
- Total 12 checks per hari
- Mayoritas checks akan di-skip oleh filter

---

### 2. Time Window Filter (Human Hours Only)

```bash
# Filter 1: Jam Aktif
current_hour_wib=$(TZ='Asia/Jakarta' date +%H)

if [ $current_hour_wib -lt 6 ] || [ $current_hour_wib -ge 22 ]; then
  echo "Outside active hours - SKIP"
  exit 0
fi
```

**Aturan:**
- ✅ **Aktif**: 06:00 - 21:59 WIB (16 jam per hari)
- ❌ **Skip**: 22:00 - 05:59 WIB (jam tidur)

**Alasan:**
- Realistis dengan perilaku manusia di Indonesia
- Tidak ada orang normal yang update blog/produk tengah malam

---

### 3. Escalating Probability Algorithm

#### POST Workflow (`update-post-metrics.yml`)

```bash
hours_since=$(( (current_time - last_run) / 3600 ))

if [ $hours_since -lt 48 ]; then
  probability=0     # < 2 hari: SKIP (terlalu baru)
elif [ $hours_since -lt 72 ]; then
  probability=10    # 2-3 hari: 10% chance
elif [ $hours_since -lt 96 ]; then
  probability=25    # 3-4 hari: 25% chance
elif [ $hours_since -lt 120 ]; then
  probability=50    # 4-5 hari: 50% chance
else
  probability=90    # 5+ hari: 90% chance (urgent!)
fi

random=$((RANDOM % 100))
if [ $random -lt $probability ]; then
  # RUN UPDATE
fi
```

**Probabilitas POST:**
| Waktu Sejak Last Update | Probability | Status |
|-------------------------|-------------|--------|
| < 48 jam (< 2 hari) | 0% | ❌ Skip |
| 48-72 jam (2-3 hari) | 10% | 🎲 Low chance |
| 72-96 jam (3-4 hari) | 25% | 🎲 Medium-low |
| 96-120 jam (4-5 hari) | 50% | 🎲 Medium-high |
| 120+ jam (5+ hari) | 90% | ✅ High (urgent) |

---

#### PRODUCT Workflow (`update-product-metrics.yml`)

```bash
hours_since=$(( (current_time - last_run) / 3600 ))

if [ $hours_since -lt 72 ]; then
  probability=0     # < 3 hari: SKIP (terlalu baru)
elif [ $hours_since -lt 96 ]; then
  probability=10    # 3-4 hari: 10% chance
elif [ $hours_since -lt 120 ]; then
  probability=25    # 4-5 hari: 25% chance
elif [ $hours_since -lt 168 ]; then
  probability=50    # 5-7 hari: 50% chance
else
  probability=90    # 7+ hari: 90% chance (urgent!)
fi
```

**Probabilitas PRODUCT:**
| Waktu Sejak Last Update | Probability | Status |
|-------------------------|-------------|--------|
| < 72 jam (< 3 hari) | 0% | ❌ Skip |
| 72-96 jam (3-4 hari) | 10% | 🎲 Low chance |
| 96-120 jam (4-5 hari) | 25% | 🎲 Medium-low |
| 120-168 jam (5-7 hari) | 50% | 🎲 Medium-high |
| 168+ jam (7+ hari) | 90% | ✅ High (urgent) |

**Perbedaan POST vs PRODUCT:**
- POST: Update lebih sering (min 2 hari) - engagement post lebih dinamis
- PRODUCT: Update lebih jarang (min 3 hari) - review produk lebih stabil

---

### 4. Random Timing Variation (Unique Timestamps)

```bash
# Add random delay: 0-59 minutes + 0-59 seconds
delay_minutes=$((RANDOM % 60))
delay_seconds=$((RANDOM % 60))
total_delay=$((delay_minutes * 60 + delay_seconds))

sleep $total_delay

final_time=$(TZ='Asia/Jakarta' date '+%Y-%m-%d %H:%M:%S %Z')
```

**Karakteristik:**
- Random delay: **0-59 menit** + **0-59 detik**
- Total range: 0 - 3599 detik (~1 jam)
- Setiap eksekusi memiliki **timestamp yang unik**
- **Tidak ada waktu yang berulang**

**Contoh:**
- Check ke-1: 08:00 → delay 23m 47s → execute at **08:23:47**
- Check ke-2: 10:00 → delay 51m 12s → execute at **10:51:12**
- Check ke-3: 14:00 → delay 5m 38s → execute at **14:05:38**

---

## Workflow Execution Flow

### Diagram Alur

```
┌─────────────────────────────────────┐
│ Cron Trigger (every 2 hours)       │
└───────────────┬─────────────────────┘
                │
                ▼
┌─────────────────────────────────────┐
│ Filter 1: Time Window Check         │
│ Is current hour in 06:00-21:59 WIB? │
└───────────────┬─────────────────────┘
                │
         ┌──────┴──────┐
         │             │
    NO   │             │  YES
         ▼             ▼
    ┌────────┐   ┌─────────────────────────┐
    │  SKIP  │   │ Filter 2: Calculate      │
    └────────┘   │ Hours Since Last Update  │
                 └───────────┬──────────────┘
                             │
                             ▼
                 ┌─────────────────────────┐
                 │ Filter 3: Check Minimum │
                 │ Gap (48h or 72h)        │
                 └───────────┬─────────────┘
                             │
                      ┌──────┴──────┐
                      │             │
                 TOO RECENT         READY
                      │             │
                      ▼             ▼
                 ┌────────┐   ┌──────────────────┐
                 │  SKIP  │   │ Calculate        │
                 └────────┘   │ Probability      │
                              └─────────┬────────┘
                                        │
                                        ▼
                              ┌──────────────────┐
                              │ Roll Dice        │
                              │ random % 100     │
                              └─────────┬────────┘
                                        │
                                 ┌──────┴──────┐
                                 │             │
                            MISS │             │  HIT
                                 ▼             ▼
                            ┌────────┐   ┌──────────────┐
                            │  SKIP  │   │ Add Random   │
                            └────────┘   │ Delay (0-59m)│
                                         └──────┬───────┘
                                                │
                                                ▼
                                         ┌──────────────┐
                                         │ EXECUTE      │
                                         │ UPDATE       │
                                         └──────────────┘
```

---

## Example Scenarios

### Scenario 1: Fresh Update (Recently Updated)

```
Current time: 2024-01-15 10:00 WIB
Last update: 2024-01-15 08:00 WIB (2 hours ago)

POST Workflow:
✓ Time window: 10:00 WIB (OK - within 06:00-21:59)
✓ Hours since: 2 hours
✗ Minimum gap: 2 hours < 48 hours minimum
→ RESULT: SKIP (too recent)
```

---

### Scenario 2: Medium Age (3 Days Old)

```
Current time: 2024-01-18 14:00 WIB
Last update: 2024-01-15 08:00 WIB (74 hours ago)

POST Workflow:
✓ Time window: 14:00 WIB (OK - within 06:00-21:59)
✓ Hours since: 74 hours (3.08 days)
✓ Minimum gap: 74 > 48 hours
✓ Probability: 10% (72-96 hours range)
✓ Random roll: 7
→ RESULT: HIT! (7 < 10) - EXECUTE UPDATE
→ Random delay: 34m 12s
→ Final execution: 14:34:12 WIB
```

---

### Scenario 3: Old Update (6 Days Old)

```
Current time: 2024-01-21 16:00 WIB
Last update: 2024-01-15 08:00 WIB (152 hours ago)

POST Workflow:
✓ Time window: 16:00 WIB (OK - within 06:00-21:59)
✓ Hours since: 152 hours (6.33 days)
✓ Minimum gap: 152 > 48 hours
✓ Probability: 90% (120+ hours range)
✓ Random roll: 45
→ RESULT: HIT! (45 < 90) - EXECUTE UPDATE
→ Random delay: 12m 58s
→ Final execution: 16:12:58 WIB
```

---

### Scenario 4: Sleep Time (Blocked)

```
Current time: 2024-01-18 23:00 WIB
Last update: 2024-01-15 08:00 WIB (87 hours ago)

POST Workflow:
✗ Time window: 23:00 WIB (FAIL - outside 06:00-21:59)
→ RESULT: SKIP (sleep hours)

Note: Even though enough time has passed (87 hours),
the update is blocked by time window filter.
Will retry at next check (01:00 WIB → still sleep → skip)
Next eligible check: 07:00 WIB
```

---

## Testing & Verification

### Local Testing Script

Gunakan script berikut untuk testing workflow logic secara lokal:

```bash
#!/bin/bash

echo "Testing Workflow Logic - Pola v2.0"
echo "===================================="

# Get last commit timestamp
last_run=$(git log -1 --format=%ct _posts/ 2>/dev/null || echo 0)
current_time=$(date +%s)
hours_since=$(( (current_time - last_run) / 3600 ))

echo "Last update: $(date -d @$last_run '+%Y-%m-%d %H:%M:%S')"
echo "Hours since: $hours_since hours"

# Check time window
current_hour_wib=$(TZ='Asia/Jakarta' date +%H)
echo "Current hour WIB: ${current_hour_wib}:00"

if [ $current_hour_wib -lt 6 ] || [ $current_hour_wib -ge 22 ]; then
    echo "❌ Outside active hours"
    exit 0
else
    echo "✅ Within active hours"
fi

# Calculate probability (POST logic)
if [ $hours_since -lt 48 ]; then
    probability=0
elif [ $hours_since -lt 72 ]; then
    probability=10
elif [ $hours_since -lt 96 ]; then
    probability=25
elif [ $hours_since -lt 120 ]; then
    probability=50
else
    probability=90
fi

random=$((RANDOM % 100))
echo "Probability: $probability%"
echo "Random roll: $random"

if [ $random -lt $probability ]; then
    echo "✅ WOULD RUN"
else
    echo "⏭️  WOULD SKIP"
fi
```

---

## Benefits & Trade-offs

### ✅ Benefits

1. **Natural & Unpredictable**
   - Tidak ada fixed pattern yang bisa diprediksi
   - Setiap eksekusi di waktu yang berbeda

2. **Human-Realistic**
   - Filter jam tidur (22:00-05:59 WIB)
   - Update hanya di jam aktif manusia Indonesia

3. **Self-Adjusting**
   - Escalating probability mencegah update terlalu lama tertunda
   - Makin lama tidak update, makin tinggi probabilitas

4. **Resource Efficient**
   - Mayoritas checks di-skip early (time window + minimum gap)
   - Actual execution rate: ~2-3x per minggu (sesuai target)

5. **Easy to Debug**
   - Clear logging di setiap step
   - Probability dan random roll terlihat di logs

### ⚠️ Trade-offs

1. **More GitHub Actions Minutes**
   - Check setiap 2 jam = 12 runs/hari
   - Tapi mayoritas exit early (< 1 menit per check)
   - Estimasi: ~10-15 menit/hari total

2. **Less Predictable for Debugging**
   - Tidak bisa predict exact execution time
   - Perlu cek workflow logs untuk troubleshooting

3. **Potential for Unlucky Streaks**
   - 10% probability bisa miss 5-10x berturut-turut
   - Mitigasi: Escalating probability (90% di 5+ hari)

---

## Configuration & Tuning

### Menyesuaikan Time Window

Edit bagian ini di workflow:

```bash
# Default: 06:00-21:59 WIB
if [ $current_hour_wib -lt 6 ] || [ $current_hour_wib -ge 22 ]; then
  exit 0
fi

# Alternatif: 07:00-23:59 WIB (lebih luas)
if [ $current_hour_wib -lt 7 ]; then
  exit 0
fi

# Alternatif: 08:00-20:59 WIB (lebih sempit)
if [ $current_hour_wib -lt 8 ] || [ $current_hour_wib -ge 21 ]; then
  exit 0
fi
```

### Menyesuaikan Probability Curve

Untuk POST workflow, edit escalation curve:

```bash
# Default (moderate)
if [ $hours_since -lt 48 ]; then
  probability=0
elif [ $hours_since -lt 72 ]; then
  probability=10
elif [ $hours_since -lt 96 ]; then
  probability=25
elif [ $hours_since -lt 120 ]; then
  probability=50
else
  probability=90
fi

# Aggressive (update lebih sering)
if [ $hours_since -lt 48 ]; then
  probability=0
elif [ $hours_since -lt 72 ]; then
  probability=30    # lebih tinggi
elif [ $hours_since -lt 96 ]; then
  probability=60    # lebih tinggi
else
  probability=95
fi

# Conservative (update lebih jarang)
if [ $hours_since -lt 48 ]; then
  probability=0
elif [ $hours_since -lt 72 ]; then
  probability=5     # lebih rendah
elif [ $hours_since -lt 96 ]; then
  probability=15    # lebih rendah
elif [ $hours_since -lt 144 ]; then
  probability=40
else
  probability=80
fi
```

### Menyesuaikan Check Frequency

Edit cron schedule:

```yaml
# Default: Every 2 hours (12 checks/day)
schedule:
  - cron: '0 */2 * * *'

# Every 3 hours (8 checks/day - lebih hemat)
schedule:
  - cron: '0 */3 * * *'

# Every 1 hour (24 checks/day - lebih responsive)
schedule:
  - cron: '0 * * * *'

# Every 4 hours (6 checks/day - sangat hemat)
schedule:
  - cron: '0 */4 * * *'
```

---

## Monitoring & Analytics

### Key Metrics to Monitor

1. **Execution Frequency**
   - Target: 2-3x per minggu untuk POST
   - Target: 1-2x per minggu untuk PRODUCT

2. **Skip Reasons**
   - Time window blocks
   - Minimum gap blocks
   - Probability misses

3. **Max Gap Between Updates**
   - Seharusnya tidak > 7 hari (90% probability)

### GitHub Actions Logs

Check workflow logs untuk melihat:

```
🕐 Current time: 2024-01-15 14:23:45 WIB
✅ Within active hours (14:00 WIB)
📅 Last update: 2024-01-12 09:15:23 WIB
📊 Time since last update: 77 hours (3.2 days)
🎲 Probability: 25% | Random roll: 18
✅ HIT! (18 < 25) - Proceeding with update
⏰ Adding timing variation: 34m 12s
✅ Executing at: 2024-01-15 14:58:57 WIB
```

---

## Migration from v1.0 to v2.0

### Checklist

- [x] Update cron schedule dari fixed slots ke `0 */2 * * *`
- [x] Tambah time window filter step
- [x] Replace simple check dengan escalating probability logic
- [x] Update random delay dari 90/120 menit ke 0-59m + 0-59s
- [x] Update commit message untuk mencerminkan new pattern
- [x] Test workflow dengan manual trigger
- [x] Monitor execution selama 1-2 minggu

### Breaking Changes

**Tidak ada breaking changes** - workflow tetap menghasilkan output yang sama (updated post/product files), hanya timing yang berubah.

---

## FAQ

### Q: Mengapa tidak pakai Poisson Distribution yang lebih natural?

**A:** Escalating probability lebih simple dan mudah di-debug, sambil tetap memberikan behavior yang natural. Poisson distribution terlalu kompleks untuk benefit yang marginal.

---

### Q: Bagaimana jika unlucky dan tidak update selama 10 hari?

**A:** Dengan 90% probability di 5+ hari dan check setiap 2 jam (8x per hari di active hours), kemungkinan miss terus menerus sangat kecil: 0.1^8 = 0.000001% per hari.

---

### Q: Apakah bisa collision antara POST dan PRODUCT workflow?

**A:** Ya bisa, tapi tidak masalah karena:
1. Mereka update file yang berbeda (_posts vs _products)
2. Git conflict handling sudah di-handle oleh GitHub Actions
3. Random delay membuat collision lebih jarang

---

### Q: Kenapa tidak pakai external scheduler seperti cron di server sendiri?

**A:** GitHub Actions sudah cukup untuk use case ini. External scheduler menambah complexity (server maintenance, monitoring, credential management) tanpa benefit yang signifikan.

---

### Q: Bagaimana cara force update tanpa menunggu probability?

**A:** Gunakan manual trigger:
1. Buka GitHub Actions tab
2. Pilih workflow (update-post-metrics atau update-product-metrics)
3. Klik "Run workflow"
4. Workflow akan bypass semua filter dan langsung execute

---

## References

- **Commit:** `be2c438` - feat: Implement Time Window + Escalating Probability scheduling pattern
- **Workflows:**
  - `.github/workflows/update-post-metrics.yml`
  - `.github/workflows/update-product-metrics.yml`
- **Pattern:** Time Window + Escalating Probability (Pola 4)

---

## Changelog

### v2.0 (2024-01-24)
- ✨ Implement Time Window + Escalating Probability pattern
- ✨ Add human hours filter (06:00-21:59 WIB)
- ✨ Replace fixed schedule dengan dynamic check every 2 hours
- ✨ Add unique timestamp generation (0-59m + 0-59s random delay)
- ✨ Self-adjusting urgency based on time since last update

### v1.0 (Initial)
- ✅ Fixed schedule dengan 4 time slots per workflow
- ✅ Simple minimum gap check (2 hari untuk POST, 3 hari untuk PRODUCT)
- ✅ Random delay 0-90/120 menit
- ❌ Predictable pattern (fixed days & times)
- ❌ No human hours filter

---

**Last Updated:** 2024-11-24
**Author:** Automated Metrics System
**Status:** Active & Production Ready
