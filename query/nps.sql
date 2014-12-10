SELECT B.ITEMABBRNM, A.NEW_CMP_MKT_CAP / SUM(A.NEW_CMP_MKT_CAP) OVER (PARTITION BY 1)
FROM JISUDEV.FNI_MFI_U_MAP_HIST A,
     FNS_J_MAST B
WHERE A.GICODE = B.GICODE
AND A.TRD_DT = '20141117'
AND A.U_CD = 'FI00.WLT.SFW'     

-- �Ϻ�
SELECT A.STD_DT, A.CLS_PRC, B.CLS_PRC CLS_PRC_BM
FROM JISUDEV.RES_STYLE_IDX A,
FNS_UD B
WHERE A.STD_DT = B.TRD_DT
AND A.SIMUL_ID = #{simul_id}
AND A.U_CD = #{u_cd}
AND A.TRD_DT BETWEEN #{t0} AND #{t1}
AND B.U_CD = #{u_cd_bm}
ORDER BY A.STD_DT ASC

-- ����
SELECT A.STD_DT, A.CLS_PRC, B.CLS_PRC CLS_PRC_BM
FROM JISUDEV.RES_STYLE_IDX A,
FNS_UD B,
FNS_UM D
WHERE A.STD_DT = B.TRD_DT
AND A.SIMUL_ID = 'NPSD9'
AND A.U_CD = 'UNIV.SCR'
AND A.STD_DT BETWEEN '20010102' AND '20141031'
AND B.U_CD = 'NPS.BM'
AND D.U_CD = 'I.001'
AND D.END_DT = A.STD_DT
ORDER BY A.STD_DT ASC

-- �ֺ�
SELECT A.STD_DT, A.CLS_PRC, B.CLS_PRC CLS_PRC_BM
FROM JISUDEV.RES_STYLE_IDX A,
FNS_UD B,
FNS_UW D
WHERE A.STD_DT = B.TRD_DT
AND A.SIMUL_ID = 'NPSD9'
AND A.U_CD = 'UNIV.SCR'
AND A.STD_DT BETWEEN '20010102' AND '20141031'
AND B.U_CD = 'NPS.BM'
AND D.U_CD = 'I.001'
AND D.END_DT = A.STD_DT
ORDER BY A.STD_DT ASC

-- �������� ����Ʈ
SELECT DISTINCT START_DT
FROM JISUDEV.RES_STYLE_UNIV
WHERE SIMUL_ID = 'NPSD9'
AND U_CD = 'UNIV.SCR'
ORDER BY START_DT ASC;

-- ������ ��¥
SELECT TRD_DT_PDAY
FROM FNC_CALENDAR
WHERE TRD_DT = '20141031'
AND OPEN_GB_STOCK = '0'

-- Ư�� ������ �������
SELECT START_DT, GICODE, ITEMABBRNM, CAP / SUM(CAP) OVER (PARTITION BY START_DT)
FROM(
SELECT A.START_DT, A.GICODE, C.ITEMABBRNM, A.WEIGHT * B.STK_QTY * B.FF_RT_BAND * B.STRT_PRC CAP
FROM JISUDEV.RES_STYLE_UNIV A,
     JISUDEV.RES_J_MAST_HIST B,
     FNS_J_MAST_HIST C
WHERE A.SIMUL_ID = 'NPSD9'
AND A.U_CD = 'UNIV.SCR'
AND A.START_DT = C.TRD_DT
AND A.GICODE = C.GICODE
AND A.START_DT = B.TRD_DT
AND A.GICODE = B.GICODE
AND A.START_DT = (SELECT MAX(START_DT)
                  FROM JISUDEV.RES_STYLE_UNIV
                  WHERE SIMUL_ID = 'NPSD9'
                  AND U_CD = 'UNIV.SCR'
                  AND START_DT < '20101231')         
)                 

-- �ų� ������ ������
SELECT SUBSTR(A.TRD_DT, 1, 4) YYYY, MAX(A.TRD_DT) TRD_DT
FROM FNC_CALENDAR A
WHERE A.MON_LAST_YN = 'Y'
AND TRD_DT BETWEEN '20010102' AND '20141115'
AND OPEN_GB_STOCK = '0'
GROUP BY SUBSTR(A.TRD_DT, 1, 4)
ORDER BY MAX(A.TRD_DT) ASC;
