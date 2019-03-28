﻿USE [master]

CREATE CERTIFICATE [TempCert]
FROM BINARY = 0x3082021D3082018AA00302010202100BC8E8E1380827B64A8387D5BE32EF36300906052B0E03021D\
050030233121301F0603550403131866757369736F66742E69742F73716C73657276657275646630\
20170D3139303332383139353031365A180F32303939313233303233303030305A30233121301F06\
03550403131866757369736F66742E69742F73716C73657276657275646630819F300D06092A8648\
86F70D010101050003818D0030818902818100D361C0D34BE3CF35822F040050D34D60E9D2C7FB89\
CF4131DA9F72F4E9DE256EB185BA2B2F341C98A8FCCFE6105D4F21D7A20CE765B7E0C6F9AA04C0AE\
E3971241FF86960C6EA2604DF85583C1CAFAFC28A74B78B94EF7A086B58D65A7374E82C27D201258\
1022037939A418DC288231B9E80A6CEF86028BAEE7025ED07BA6F50203010001A358305630540603\
551D01044D304B80107690D1D6878C852CBC97F7A37D983191A12530233121301F06035504031318\
66757369736F66742E69742F73716C73657276657275646682100BC8E8E1380827B64A8387D5BE32\
EF36300906052B0E03021D0500038181003D8FD6EF9282A4E329D5C2033D48A6BDB7176611A5D414\
A7D971273163902488C06B821F62ED20B9A6D8A553A36FA06622E9D05F189C5325CAF5A17B74DDB4\
728B1D3A824C12CD1DF567286325E5A92DF9C2FB854032AE39E91A2A3EB78E2A02BF72D173CC9B37\
6435D5F6892B9338066642CDC59F21C9015AEAD258277E9A6B;

CREATE LOGIN [TempLogin] FROM CERTIFICATE [TempCert];

GRANT UNSAFE ASSEMBLY TO [TempLogin];

CREATE ASSEMBLY [Sql2017Clr-KeyAsm] FROM 0x4D5A90000300000004000000FFFF0000B80000000000000040000000000000000000000000000000\
0000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD215468\
69732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A\
2400000000000000504500004C010300CA219D5C0000000000000000E00022200B01300000080000\
00060000000000005A27000000200000004000000000001000200000000200000400000000000000\
060000000000000000800000000200000D5200000300608500001000001000000000100000100000\
00000000100000000000000000000000082700004F00000000400000A80300000000000000000000\
00100000D8030000006000000C000000D02500001C00000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000200000080000000000000000000000\
082000004800000000000000000000002E7465787400000060070000002000000008000000020000\
000000000000000000000000200000602E72737263000000A80300000040000000040000000A0000\
000000000000000000000000400000402E72656C6F6300000C0000000060000000020000000E0000\
00000000000000000000000040000042000000000000000000000000000000003C27000000000000\
48000000020005005020000000050000090000000000000000000000000000005025000080000000\
000000000000000000000000000000000000000000000000000000000000000042534A4201000100\
000000000C00000076342E302E33303331390000000005006C00000058010000237E0000C4010000\
EC01000023537472696E677300000000B00300000400000023555300B40300001000000023475549\
44000000C40300003C01000023426C6F620000000000000002000001071400000900000000FA0133\
00160000010000000D000000010000000C0000000C000000010000000100000000005F0101000000\
00000600D400AC0106004101AC010600350099010F00DD0100000600490081010600B70081010600\
980081010600280181010600F400810106000D01810106006000810106007B00810106001300CC01\
0000000001000000000001000100090093010100110093010600190093010A002900930110003100\
93011000390093011000410093011000490093011000510093011000590093011000610093011000\
6900930110002E000B00C0002E001300C9002E001B00E8002E002300F1002E002B0005012E003300\
05012E003B0005012E004300F1002E004B000B012E00530005012E005B0023012E00630030010480\
00000100000000000000010000001E007201000004000000000000000000000015000A0000000000\
00000000003C4D6F64756C653E006D73636F726C6962004E65757472616C5265736F75726365734C\
616E67756167654174747269627574650044656275676761626C6541747472696275746500417373\
656D626C795469746C6541747472696275746500417373656D626C7954726164656D61726B417474\
72696275746500417373656D626C7946696C6556657273696F6E4174747269627574650041737365\
6D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C794465736372\
697074696F6E41747472696275746500436F6D70696C6174696F6E52656C61786174696F6E734174\
7472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C\
79436F7079726967687441747472696275746500417373656D626C79436F6D70616E794174747269\
627574650052756E74696D65436F6D7061746962696C6974794174747269627574650053514C3230\
31375F4B657941736D2E646C6C0053514C323031375F4B657941736D0053797374656D2E5265666C\
656374696F6E002E63746F720053797374656D2E446961676E6F73746963730053797374656D2E52\
756E74696D652E436F6D70696C657253657276696365730053797374656D2E5265736F7572636573\
00446562756767696E674D6F6465730000000000F9A072B462162E498F862BCDEC0E6CC000042001\
010803200001052001011111042001010E08B77A5C561934E08980A0002400000480000094000000\
06020000002400005253413100040000010001007D6BDDE17AF456BD3F95F02A3AB4BF2DE9EE06DB\
00C5AE9B3A526994783E11D0C6BB90B1260CEC5391FE5F81344B5EB379A7E21A04A16E5FABD06C98\
BFDFE4C4E042B95241C8B2351D90E4D07643190C9874610BDE9C452B19E13808AF00EB6164FB0C79\
8639CA0CDA3737618102DF5206B696E078C1E6A629B500D65C2F73C60801000800000000001E0100\
0100540216577261704E6F6E457863657074696F6E5468726F777301080100020000000000130100\
0E53514C323031375F4B657941736D000005010000000017010012436F7079726967687420C2A920\
203230313900000C010007312E302E302E3000000A010005656E2D55530000007C8D8408B0EDCC77\
752A66B63A16EE1F5A377FD053132DF0A93E979750E3CD0C583749CD00A762F15082D78A61AB8B41\
BC28E64D730BCCC6CBFE050525F30394A7893FFCFBE7AAADC36B4E8F5865770EF1E7A60F2A154881\
F308AC352AE8E0239A05E5E27E0417EB5FB54E4510C665719DD60BB6DB2A49D2A519FA0788C11F27\
00000000C9219D5C00000000020000001C010000EC250000EC070000525344533CA6F675DD742049\
9E312B5951DC89F901000000443A5C50726F6A656374735C436F726532305C546573745C53716C43\
6C725C53514C323031375F4B657941736D5C6F626A5C52656C656173655C53514C323031375F4B65\
7941736D2E7064620000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000003027000000000000\
000000004A2700000020000000000000000000000000000000000000000000003C27000000000000\
0000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF2500200010\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000100100000001800008000000000000000000000000000000100\
0100000030000080000000000000000000000000000001000000000048000000584000004C030000\
00000000000000004C0334000000560053005F00560045005200530049004F004E005F0049004E00\
46004F0000000000BD04EFFE00000100000001000000000000000100000000003F00000000000000\
0400000002000000000000000000000000000000440000000100560061007200460069006C006500\
49006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00\
000000000000B004AC020000010053007400720069006E006700460069006C00650049006E006600\
6F0000008802000001003000300030003000300034006200300000001A000100010043006F006D00\
6D0065006E007400730000000000000022000100010043006F006D00700061006E0079004E006100\
6D006500000000000000000046000F000100460069006C0065004400650073006300720069007000\
740069006F006E0000000000530051004C0032003000310037005F004B0065007900410073006D00\
00000000300008000100460069006C006500560065007200730069006F006E000000000031002E00\
30002E0030002E003000000046001300010049006E007400650072006E0061006C004E0061006D00\
65000000530051004C0032003000310037005F004B0065007900410073006D002E0064006C006C00\
000000004800120001004C006500670061006C0043006F0070007900720069006700680074000000\
43006F0070007900720069006700680074002000A90020002000320030003100390000002A000100\
01004C006500670061006C00540072006100640065006D00610072006B0073000000000000000000\
4E00130001004F0072006900670069006E0061006C00460069006C0065006E0061006D0065000000\
530051004C0032003000310037005F004B0065007900410073006D002E0064006C006C0000000000\
3E000F000100500072006F0064007500630074004E0061006D00650000000000530051004C003200\
3000310037005F004B0065007900410073006D0000000000340008000100500072006F0064007500\
63007400560065007200730069006F006E00000031002E0030002E0030002E003000000038000800\
010041007300730065006D0062006C0079002000560065007200730069006F006E00000031002E00\
30002E0030002E003000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
000000000000000000000000000000000000000000000000002000000C0000005C37000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000000D803000000020200308203CB06092A864886F70D010702A0\
8203BC308203B8020101310B300906052B0E03021A0500304C060A2B060104018237020104A03E30\
3C3017060A2B06010401823702010F3009030100A004A20280003021300906052B0E03021A050004\
14F133A94DEFE2AAC67013CBE252CA897E0CAB5A3EA08202213082021D3082018AA0030201020210\
0BC8E8E1380827B64A8387D5BE32EF36300906052B0E03021D050030233121301F06035504031318\
66757369736F66742E69742F73716C7365727665727564663020170D313930333238313935303136\
5A180F32303939313233303233303030305A30233121301F0603550403131866757369736F66742E\
69742F73716C73657276657275646630819F300D06092A864886F70D010101050003818D00308189\
02818100D361C0D34BE3CF35822F040050D34D60E9D2C7FB89CF4131DA9F72F4E9DE256EB185BA2B\
2F341C98A8FCCFE6105D4F21D7A20CE765B7E0C6F9AA04C0AEE3971241FF86960C6EA2604DF85583\
C1CAFAFC28A74B78B94EF7A086B58D65A7374E82C27D2012581022037939A418DC288231B9E80A6C\
EF86028BAEE7025ED07BA6F50203010001A358305630540603551D01044D304B80107690D1D6878C\
852CBC97F7A37D983191A12530233121301F0603550403131866757369736F66742E69742F73716C\
73657276657275646682100BC8E8E1380827B64A8387D5BE32EF36300906052B0E03021D05000381\
81003D8FD6EF9282A4E329D5C2033D48A6BDB7176611A5D414A7D971273163902488C06B821F62ED\
20B9A6D8A553A36FA06622E9D05F189C5325CAF5A17B74DDB4728B1D3A824C12CD1DF567286325E5\
A92DF9C2FB854032AE39E91A2A3EB78E2A02BF72D173CC9B376435D5F6892B9338066642CDC59F21\
C9015AEAD258277E9A6B318201313082012D020101303730233121301F0603550403131866757369\
736F66742E69742F73716C73657276657275646602100BC8E8E1380827B64A8387D5BE32EF363009\
06052B0E03021A0500A0523010060A2B06010401823702010C31023000301906092A864886F70D01\
0903310C060A2B060104018237020104302306092A864886F70D010904311604147E46F9C913D2FC\
43F5BF8329953239CBDB5A7488300D06092A864886F70D01010105000481800EAE6E79A18D19904F\
4D1E33DD5C1F80B63ED45A2DA5BA39913AD57637D7895EE52AE5410E521F9636A3D554CC9302664C\
ABBEF5DCCBB3CBDED44D270FE802B7AB2DD9CD1420405F804627EA845D7E2D51463D9BDA9AAED3F4\
77B6BB9195EB661408AE15533D7C9D3A880BCB31AB845A9E38B86218FDB8ECFBA6269B9A5CF6E400;

CREATE ASYMMETRIC KEY [Sql2017Clr-Key] FROM ASSEMBLY [Sql2017Clr-KeyAsm];

CREATE LOGIN [Sql2017Clr-Login] FROM ASYMMETRIC KEY [Sql2017Clr-Key];

GRANT UNSAFE ASSEMBLY TO [Sql2017Clr-Login]; -- REQUIRED!!!!

DROP ASSEMBLY [Sql2017Clr-KeyAsm];

DROP LOGIN [TempLogin];

DROP CERTIFICATE [TempCert];
