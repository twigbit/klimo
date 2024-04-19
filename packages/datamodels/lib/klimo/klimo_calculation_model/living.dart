import 'package:built_collection/built_collection.dart';

import '../../calculation_model.dart';

void buildLivingSection(FormulaNodeBuilder b) {
  b.key = "living";

  // ---
  // --- Berechnungsparameter
  // ---
  b.nodes.addAll(
    [
      //Anlagenaufwandszahl
      FormulaNode.param("e_Kessel", 1.3),
      FormulaNode.param("e_WP", 0.44),
      FormulaNode.param("e_FW", 1.1),
      //Primärenergiefaktor
      FormulaNode.param("fP_Gas", 1.1),
      FormulaNode.param("fP_Oel", 1.1),
      FormulaNode.param("fP_Bio", 0.2),
      FormulaNode.param("fP_FW", 0.7),
      FormulaNode.param("fP_Strom_Mix", 1.8),
      FormulaNode.param("fP_Strom_Oeko", 0.024),
      //Emissionsfaktoren
      FormulaNode.param("fEm_Gas", 0.22 /* kgCO2/kWh */),
      FormulaNode.param("fEm_Oel", 0.28 /* kgCO2/kWh */),
      //TODO check value of bio coefficient
      FormulaNode.param("fEm_Bio", 0.27 /* kgCO2/kWh */),
      // FormulaNode.param("fEm_Strom_Oeko", 0.1 /* kgCO2/kWh */),
      // Note: Kasseler Ökostrom ist klimaneutral
      FormulaNode.param("fEm_Strom_Oeko", 0.0 /* kgCO2/kWh */),
      FormulaNode.param("fEm_Strom_Mix", 0.401 /* kgCO2/kWh */),
      FormulaNode.param("fEm_FW", 0.2 /* kgCO2/kWh */),
      FormulaNode.param("fEm_Sonstiges", 0.24 /* kgCO2/kWh */),
      // Heizbedarfs- und -verbrauchskorrelationen
      FormulaNode.param("k", 0.85),
      // spezieller Heizwärmebedarf nach Baualtersklasse und Gebäudetyp
      // BAK vor 1948
      // unsaniert
      FormulaNode.param("EZFH_1_unsaniert", 183.5 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_unsaniert", 160.2 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_unsaniert", 165.4 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_unsaniert", 131.1 /* kWh/mWF²a*/),
      //saniert
      FormulaNode.param("EZFH_1_Dach", 161.8 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Fenster", 176.5 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Fassade", 137.6 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Boden", 163.5 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Dach_Fenster", 148.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Dach_Fassade", 115.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Dach_Boden", 134.7 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Fenster_Boden", 133.5 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Fenster_Fassade", 126.6 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Fassade_Boden", 117.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Dach_Fenster_Boden", 94.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Dach_Fenster_Fassade", 87.3 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Dach_Fassade_Boden", 90.3 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_1_Fenster_Fassade_Boden", 92.7 /* kWh/mWF²a*/),
      FormulaNode.param(
          "EZFH_1_Dach_Fenster_Fassade_Boden", 75.2 /* kWh/mWF²a*/),

      FormulaNode.param("RH_1_Dach", 143.7 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Fenster", 154.0 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Fassade", 148.1 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Boden", 145.2 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Fenster", 111.6 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Fassade", 120.7 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Boden", 129.2 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Fenster_Boden", 114.9 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Fenster_Fassade", 123.7 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Fassade_Boden", 122.6 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Fenster_Boden", 87.0 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Fenster_Fassade", 91.8 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Fassade_Boden", 89.8 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Fenster_Fassade_Boden", 86.5 /* kWh/mWF²a*/),
      FormulaNode.param("RH_1_Dach_Fenster_Fassade_Boden", 72.1 /* kWh/mWF²a*/),

      FormulaNode.param("KMFH_1_Dach", 152.2 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Fenster", 148.9 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Fassade", 124.1 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Boden", 153.7 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Dach_Fenster", 129.0 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Dach_Fassade", 105.4 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Dach_Boden", 126.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Fenster_Boden", 124.4 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Fenster_Fassade", 108.9 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Fassade_Boden", 107.4 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Dach_Fenster_Boden", 97.4 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Dach_Fenster_Fassade", 81.6 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Dach_Fassade_Boden", 94.7 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_1_Fenster_Fassade_Boden", 85.1 /* kWh/mWF²a*/),
      FormulaNode.param(
          "KMFH_1_Dach_Fenster_Fassade_Boden", 66.2 /* kWh/mWF²a*/),

      FormulaNode.param("GMFH_1_Dach", 120.6 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Fenster", 111.5 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Fassade", 98.3 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Boden", 121.8 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Dach_Fenster", 99.1 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Dach_Fassade", 88.6 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Dach_Boden", 115.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Fenster_Boden", 100.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Fenster_Fassade", 85.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Fassade_Boden", 92.3 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Dach_Fenster_Boden", 79.3 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Dach_Fenster_Fassade", 73.9 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Dach_Fassade_Boden", 79.4 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_1_Fenster_Fassade_Boden", 80.7 /* kWh/mWF²a*/),
      FormulaNode.param(
          "GMFH_1_Dach_Fenster_Fassade_Boden", 62.9 /* kWh/mWF²a*/),

      // BAK 1949 - 1978
      // unsaniert
      FormulaNode.param("EZFH_2_unsaniert", 192.73 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_unsaniert", 172.97 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_unsaniert", 174.81 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_unsaniert", 142.38 /* kWh/mWF²a*/),
      // saniert
      FormulaNode.param("EZFH_2_Dach", 168.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Fenster", 183.4 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Fassade", 134.9 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Boden", 169.6 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Dach_Fenster", 132.7 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Dach_Fassade", 113.5 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Dach_Boden", 139.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Fenster_Boden", 134.3 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Fenster_Fassade", 130.7 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Fassade_Boden", 115.7 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Dach_Fenster_Boden", 96.7 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Dach_Fenster_Fassade", 85.1 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Dach_Fassade_Boden", 92.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_2_Fenster_Fassade_Boden", 91.2 /* kWh/mWF²a*/),
      FormulaNode.param(
          "EZFH_2_Dach_Fenster_Fassade_Boden", 75.0 /* kWh/mWF²a*/),

      FormulaNode.param("RH_2_Dach", 154.9 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Fenster", 166.5 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Fassade", 157.1 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Boden", 156.5 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Fenster", 109.5 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Fassade", 118.7 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Boden", 134.1 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Fenster_Boden", 112.9 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Fenster_Fassade", 123.0 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Fassade_Boden", 121.6 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Fenster_Boden", 85.6 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Fenster_Fassade", 89.1 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Fassade_Boden", 88.3 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Fenster_Fassade_Boden", 86.2 /* kWh/mWF²a*/),
      FormulaNode.param("RH_2_Dach_Fenster_Fassade_Boden", 72.6 /* kWh/mWF²a*/),

      FormulaNode.param("KMFH_2_Dach", 164.7 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Fenster", 148.0 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Fassade", 122.4 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Boden", 166.3 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Dach_Fenster", 132.1 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Dach_Fassade", 103.8 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Dach_Boden", 129.3 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Fenster_Boden", 143.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Fenster_Fassade", 111.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Fassade_Boden", 105.8 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Dach_Fenster_Boden", 95.8 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Dach_Fenster_Fassade", 83.1 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Dach_Fassade_Boden", 93.3 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_2_Fenster_Fassade_Boden", 87.4 /* kWh/mWF²a*/),
      FormulaNode.param(
          "KMFH_2_Dach_Fenster_Fassade_Boden", 66.4 /* kWh/mWF²a*/),

      FormulaNode.param("GMFH_2_Dach", 133.8 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Fenster", 129.9 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Fassade", 99.7 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Boden", 135.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Dach_Fenster", 100.9 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Dach_Fassade", 91.5 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Dach_Boden", 112.7 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Fenster_Boden", 103.1 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Fenster_Fassade", 89.0 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Fassade_Boden", 93.4 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Dach_Fenster_Boden", 81.4 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Dach_Fenster_Fassade", 76.0 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Dach_Fassade_Boden", 80.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_2_Fenster_Fassade_Boden", 82.8 /* kWh/mWF²a*/),
      FormulaNode.param(
          "GMFH_2_Dach_Fenster_Fassade_Boden", 61.2 /* kWh/mWF²a*/),

      // BAK 1979 - 2001
      // unsaniert
      FormulaNode.param("EZFH_3_unsaniert", 129.07 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_unsaniert", 115.23 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_unsaniert", 111.37 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_unsaniert", 88.26 /* kWh/mWF²a*/),
      // saniert
      FormulaNode.param("EZFH_3_Dach", 116.0 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Fenster", 118.1 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Fassade", 96.8 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Boden", 117.2 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Dach_Fenster", 105.6 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Dach_Fassade", 99.2 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Dach_Boden", 105.1 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Fenster_Boden", 106.7 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Fenster_Fassade", 108.4 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Fassade_Boden", 104.1 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Dach_Fenster_Boden", 85.1 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Dach_Fenster_Fassade", 84.6 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Dach_Fassade_Boden", 81.8 /* kWh/mWF²a*/),
      FormulaNode.param("EZFH_3_Fenster_Fassade_Boden", 87.5 /* kWh/mWF²a*/),
      FormulaNode.param(
          "EZFH_3_Dach_Fenster_Fassade_Boden", 71.0 /* kWh/mWF²a*/),

      FormulaNode.param("RH_3_Dach", 108.7 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Fenster", 107.9 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Fassade", 96.4 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Boden", 109.8 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Fenster", 101.4 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Fassade", 97.3 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Boden", 101.2 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Fenster_Boden", 102.4 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Fenster_Fassade", 106.7 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Fassade_Boden", 100.1 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Fenster_Boden", 82.1 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Fenster_Fassade", 81.0 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Fassade_Boden", 78.3 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Fenster_Fassade_Boden", 83.2 /* kWh/mWF²a*/),
      FormulaNode.param("RH_3_Dach_Fenster_Fassade_Boden", 72.6 /* kWh/mWF²a*/),

      FormulaNode.param("KMFH_3_Dach", 102.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Fenster", 103.2 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Fassade", 93.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Boden", 103.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Dach_Fenster", 95.1 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Dach_Fassade", 92.6 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Dach_Boden", 96.2 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Fenster_Boden", 96.1 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Fenster_Fassade", 93.8 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Fassade_Boden", 91.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Dach_Fenster_Boden", 83.5 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Dach_Fenster_Fassade", 82.3 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Dach_Fassade_Boden", 81.6 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_3_Fenster_Fassade_Boden", 83.6 /* kWh/mWF²a*/),
      FormulaNode.param(
          "KMFH_3_Dach_Fenster_Fassade_Boden", 64.6 /* kWh/mWF²a*/),

      FormulaNode.param("GMFH_3_Dach", 85.6 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Fenster", 76.0 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Fassade", 73.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Boden", 86.5 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Dach_Fenster", 82.3 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Dach_Fassade", 82.8 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Dach_Boden", 87.1 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Fenster_Boden", 89.1 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Fenster_Fassade", 87.7 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Fassade_Boden", 86.4 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Dach_Fenster_Boden", 74.4 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Dach_Fenster_Fassade", 71.6 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Dach_Fassade_Boden", 74.2 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_3_Fenster_Fassade_Boden", 74.3 /* kWh/mWF²a*/),
      FormulaNode.param(
          "GMFH_3_Dach_Fenster_Fassade_Boden", 60.0 /* kWh/mWF²a*/),

      // BAK 2002 - 2015
      FormulaNode.param("EZFH_4_unsaniert", 91.4 /* kWh/mWF²a*/),
      FormulaNode.param("RH_4_unsaniert", 82.2 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_4_unsaniert", 66.9 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_4_unsaniert", 62.1 /* kWh/mWF²a*/),
      // BAK ab 2016
      FormulaNode.param("EZFH_5_unsaniert", 70.0 /* kWh/mWF²a*/),
      FormulaNode.param("RH_5_unsaniert", 65.0 /* kWh/mWF²a*/),
      FormulaNode.param("KMFH_5_unsaniert", 60.0 /* kWh/mWF²a*/),
      FormulaNode.param("GMFH_5_unsaniert", 50.0 /* kWh/mWF²a*/),
    ],
  );

  // ---
  // --- Berechnung
  // ---
  b.nodes.addAll(
    [
      //Heizwärmebedarf pro Jahr, geschätzt anhand von Gebäudedaten
      FormulaNode(
        (n) => n
          ..key = "heating_requirement_estimated"
          ..footprint(
            (input, ref) {
              var buildingType = input<String>("..building_type");
              var buildingAge = input<String>("..building_age_category");
              var renovation =
                  input<BuiltList<Object>>("..renovation_since_construction");
              var specificHeatingRequirementEstimated = .0;

              switch (buildingAge) {
                case "building_age_category_before_1948":
                  if (renovation.isEmpty) {
                    switch (buildingType) {
                      case "building_type_ezfh":
                        specificHeatingRequirementEstimated =
                            ref("..EZFH_1_unsaniert");
                        break;
                      case "building_type_rh":
                        specificHeatingRequirementEstimated =
                            ref("..RH_1_unsaniert");
                        break;
                      case "building_type_kmfh":
                        specificHeatingRequirementEstimated =
                            ref("..KMFH_1_unsaniert");
                        break;
                      case "building_type_gmfh":
                        specificHeatingRequirementEstimated =
                            ref("..GMFH_1_unsaniert");
                        break;
                    }
                  } else if (renovation.length == 1) {
                    if (renovation.contains("type_of_renovation_roof")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_window")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Fenster");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Fenster");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Fenster");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Fenster");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Fassade");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 2) {
                    if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach_Fenster");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach_Fenster");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach_Fenster");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach_Fenster");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach_Fassade");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Fenster_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Fenster_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Fenster_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Fenster_Fassade");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Fenster_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Fenster_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Fenster_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Fenster_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Fassade_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 3) {
                    if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach_Fenster_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach_Fenster_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach_Fenster_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach_Fenster_Fassade");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach_Fenster_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach_Fenster_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach_Fenster_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach_Fenster_Boden");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Dach_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Dach_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Dach_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Dach_Fassade_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_1_Fenster_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_1_Fenster_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_1_Fenster_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_1_Fenster_Fassade_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 4) {
                    switch (buildingType) {
                      case "building_type_ezfh":
                        specificHeatingRequirementEstimated =
                            ref("..EZFH_1_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_rh":
                        specificHeatingRequirementEstimated =
                            ref("..RH_1_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_kmfh":
                        specificHeatingRequirementEstimated =
                            ref("..KMFH_1_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_gmfh":
                        specificHeatingRequirementEstimated =
                            ref("..GMFH_1_Dach_Fenster_Fassade_Boden");
                        break;
                    }
                  }
                  break;
                case "building_age_category_1949_to_1978":
                  if (renovation.isEmpty) {
                    switch (buildingType) {
                      case "building_type_ezfh":
                        specificHeatingRequirementEstimated =
                            ref("..EZFH_2_unsaniert");
                        break;
                      case "building_type_rh":
                        specificHeatingRequirementEstimated =
                            ref("..RH_2_unsaniert");
                        break;
                      case "building_type_kmfh":
                        specificHeatingRequirementEstimated =
                            ref("..KMFH_2_unsaniert");
                        break;
                      case "building_type_gmfh":
                        specificHeatingRequirementEstimated =
                            ref("..GMFH_2_unsaniert");
                        break;
                    }
                  } else if (renovation.length == 1) {
                    if (renovation.contains("type_of_renovation_roof")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_window")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Fenster");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Fenster");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Fenster");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Fenster");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Fassade");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 2) {
                    if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach_Fenster");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach_Fenster");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach_Fenster");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach_Fenster");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach_Fassade");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Fenster_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Fenster_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Fenster_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Fenster_Fassade");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Fenster_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Fenster_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Fenster_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Fenster_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Fassade_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 3) {
                    if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach_Fenster_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach_Fenster_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach_Fenster_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach_Fenster_Fassade");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach_Fenster_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach_Fenster_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach_Fenster_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach_Fenster_Boden");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Dach_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Dach_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Dach_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Dach_Fassade_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_2_Fenster_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_2_Fenster_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_2_Fenster_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_2_Fenster_Fassade_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 4) {
                    switch (buildingType) {
                      case "building_type_ezfh":
                        specificHeatingRequirementEstimated =
                            ref("..EZFH_2_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_rh":
                        specificHeatingRequirementEstimated =
                            ref("..RH_2_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_kmfh":
                        specificHeatingRequirementEstimated =
                            ref("..KMFH_2_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_gmfh":
                        specificHeatingRequirementEstimated =
                            ref("..GMFH_2_Dach_Fenster_Fassade_Boden");
                        break;
                    }
                  }
                  break;
                case "building_age_category_1979_to_2001":
                  if (renovation.isEmpty) {
                    switch (buildingType) {
                      case "building_type_ezfh":
                        specificHeatingRequirementEstimated =
                            ref("..EZFH_3_unsaniert");
                        break;
                      case "building_type_rh":
                        specificHeatingRequirementEstimated =
                            ref("..RH_3_unsaniert");
                        break;
                      case "building_type_kmfh":
                        specificHeatingRequirementEstimated =
                            ref("..KMFH_3_unsaniert");
                        break;
                      case "building_type_gmfh":
                        specificHeatingRequirementEstimated =
                            ref("..GMFH_3_unsaniert");
                        break;
                    }
                  } else if (renovation.length == 1) {
                    if (renovation.contains("type_of_renovation_roof")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_window")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Fenster");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Fenster");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Fenster");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Fenster");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Fassade");
                          break;
                      }
                    } else if (renovation
                        .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 2) {
                    if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach_Fenster");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach_Fenster");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach_Fenster");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach_Fenster");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach_Fassade");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Fenster_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Fenster_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Fenster_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Fenster_Fassade");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Fenster_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Fenster_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Fenster_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Fenster_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Fassade_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 3) {
                    if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_facade")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach_Fenster_Fassade");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach_Fenster_Fassade");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach_Fenster_Fassade");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach_Fenster_Fassade");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_window") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach_Fenster_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach_Fenster_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach_Fenster_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach_Fenster_Boden");
                          break;
                      }
                    } else if (renovation.contains("type_of_renovation_roof") &&
                        renovation.contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Dach_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Dach_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Dach_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Dach_Fassade_Boden");
                          break;
                      }
                    } else if (renovation
                            .contains("type_of_renovation_window") &&
                        renovation.contains("type_of_renovation_facade") &&
                        renovation
                            .contains("type_of_renovation_basement_ceiling")) {
                      switch (buildingType) {
                        case "building_type_ezfh":
                          specificHeatingRequirementEstimated =
                              ref("..EZFH_3_Fenster_Fassade_Boden");
                          break;
                        case "building_type_rh":
                          specificHeatingRequirementEstimated =
                              ref("..RH_3_Fenster_Fassade_Boden");
                          break;
                        case "building_type_kmfh":
                          specificHeatingRequirementEstimated =
                              ref("..KMFH_3_Fenster_Fassade_Boden");
                          break;
                        case "building_type_gmfh":
                          specificHeatingRequirementEstimated =
                              ref("..GMFH_3_Fenster_Fassade_Boden");
                          break;
                      }
                    }
                  } else if (renovation.length == 4) {
                    switch (buildingType) {
                      case "building_type_ezfh":
                        specificHeatingRequirementEstimated =
                            ref("..EZFH_3_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_rh":
                        specificHeatingRequirementEstimated =
                            ref("..RH_3_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_kmfh":
                        specificHeatingRequirementEstimated =
                            ref("..KMFH_3_Dach_Fenster_Fassade_Boden");
                        break;
                      case "building_type_gmfh":
                        specificHeatingRequirementEstimated =
                            ref("..GMFH_3_Dach_Fenster_Fassade_Boden");
                        break;
                    }
                  }
                  break;
                case "building_age_category_2002_to_2015":
                  switch (buildingType) {
                    case "building_type_ezfh":
                      specificHeatingRequirementEstimated =
                          ref("..EZFH_4_unsaniert");
                      break;
                    case "building_type_rh":
                      specificHeatingRequirementEstimated =
                          ref("..RH_4_unsaniert");
                      break;
                    case "building_type_kmfh":
                      specificHeatingRequirementEstimated =
                          ref("..KMFH_4_unsaniert");
                      break;
                    case "building_type_gmfh":
                      specificHeatingRequirementEstimated =
                          ref("..GMFH_4_unsaniert");
                      break;
                  }

                  break;
                case "building_age_category_from_2016":
                  switch (buildingType) {
                    case "building_type_ezfh":
                      specificHeatingRequirementEstimated =
                          ref("..EZFH_5_unsaniert");
                      break;
                    case "building_type_rh":
                      specificHeatingRequirementEstimated =
                          ref("..RH_5_unsaniert");
                      break;
                    case "building_type_kmfh":
                      specificHeatingRequirementEstimated =
                          ref("..KMFH_5_unsaniert");
                      break;
                    case "building_type_gmfh":
                      specificHeatingRequirementEstimated =
                          ref("..GMFH_5_unsaniert");
                      break;
                  }

                  break;
              }
              return specificHeatingRequirementEstimated;
            },
          ),
      ),

      //TODO check if we should add a node that can store heat generator type?
      //Endenergiebedarf pro Jahr
      FormulaNode(
        (n) => n
          ..key = "final_energy_requirement"
          ..footprint(
            (input, ref) {
              var specificFinalEnergyRequirement =
                  input<double>("..specific_final_energy_requirement");
              var livingArea = input<double>("..living_area");
              var energySource = input<String>("..energy_source");

              var finalEnergyRequirement = .0;

              if (specificFinalEnergyRequirement != 0) {
                //wenn Nutzer Wert direkt eingibt
                finalEnergyRequirement =
                    specificFinalEnergyRequirement * livingArea;
              } else {
                //sonst Berechnung mittels Heizwärmebedarfsschätzung und Anlagenaufwandszahl in Abhängigkeit vom Energieträger/Wärmeerzeugertyp
                var estimatedHeatingRequirement =
                    ref("..heating_requirement_estimated") * livingArea;
                if (energySource == "energy_source_district_heating") {
                  finalEnergyRequirement =
                      estimatedHeatingRequirement * ref("..e_FW");
                } else if (energySource == "energy_source_electricity") {
                  finalEnergyRequirement =
                      estimatedHeatingRequirement * ref("..e_WP");
                } else {
                  finalEnergyRequirement =
                      estimatedHeatingRequirement * ref("..e_Kessel");
                }
              }
              return finalEnergyRequirement;
            },
          ),
      ),

      // Heizwärmeverbrauch pro Jahr bzw. Endenergieverbrauch ermittelt aus Bedarf und Korrelationskoeffizienten)
      FormulaNode(
        (n) => n
          ..key = "energy_consumption"
          ..footprint(
            (input, ref) {
              var heatingConsumption =
                  input<double>("..annual_heat_consumption");
              var energySource = input<String>("..energy_source");
              var heatingConsumptionUnit =
                  input<String>("..annual_heat_consumption_unit");

              var isSecondaryGenerationHeat =
                  input<bool>("..secondary_generation_heat");
              var secondaryGenerationHeatPower = input<double>(
                  "..secondary_generation_heat.secondary_generation_heat_power");

              var isSecondaryGenerationSolarThermal =
                  input<bool>("..secondary_generation_solar_thermal");
              var secondaryGenerationSolarThermalPower = input<double>(
                  "..secondary_generation_solar_thermal.secondary_generation_solar_thermal_power");

              var energyConsumption = .0;

              // Idee ist hier den Default Wert explizit zu setzen und folgend über Berechnungsmethode zu entscheiden
              if (heatingConsumption == 0 &&
                  ref("..final_energy_requirement") == 0) {
                energyConsumption = 15072.0;
              } else if (heatingConsumption != 0) {
                // Umrechnungen für den Fall, dass Einheit anders ist als kWh
                if (heatingConsumptionUnit ==
                    "annual_heat_consumption_unit_mwh") {
                  heatingConsumption *= 1000;
                } else if (heatingConsumptionUnit ==
                    "annual_heat_consumption_unit_l") {
                  heatingConsumption /= 0.1;
                } else if (heatingConsumptionUnit ==
                    "annual_heat_consumption_unit_kg") {
                  heatingConsumption /= 0.2;
                } else if (heatingConsumptionUnit ==
                    "annual_heat_consumption_unit_m3") {
                  if (energySource == "energy_source_biomass") {
                    heatingConsumption *= 1000;
                  } else {
                    heatingConsumption *= 10000;
                  }
                }
                energyConsumption = heatingConsumption.toDouble();
              } else {
                energyConsumption = ref("..final_energy_requirement");
                if (isSecondaryGenerationHeat &&
                    isSecondaryGenerationSolarThermal) {
                  energyConsumption -= (secondaryGenerationHeatPower +
                      secondaryGenerationSolarThermalPower);
                } else if (isSecondaryGenerationHeat &&
                    !isSecondaryGenerationSolarThermal) {
                  energyConsumption -= secondaryGenerationHeatPower;
                } else if (!isSecondaryGenerationHeat &&
                    isSecondaryGenerationSolarThermal) {
                  energyConsumption -= secondaryGenerationSolarThermalPower;
                }

                energyConsumption *= ref("..k");
              }

              return energyConsumption;
            },
          ),
      ),
    ],
  );

  // ---
  // --- Outputparameter
  // ---
  b.nodes.addAll(
    [
      //CO2 Emissionen Wärme
      FormulaNode((n) => n
        ..key = "heat_emission"
        ..footprint((input, ref) {
          var energyConsumption = ref("..energy_consumption");
          var fEmEnergy = .0;
          var energySource = input<String>("..energy_source");
          var powerConsumptionSource =
              input<String>("..power_consumption_source");

          var fEmEnergyWater = .0;
          var isSeparatedHeatProvision = input<bool>("..heat_water_separated");
          var energySourceWater =
              input<String>("..heat_water_separated.energy_source_water");
          var heatingConsumptionWater = input<double>(
              "..heat_water_separated.annual_heat_consumption_water");
          var heatingConsumptionUnitWater = input<String>(
              "..heat_water_separated.annual_heat_consumption_water_unit");

          switch (energySource) {
            case "energy_source_gas":
              fEmEnergy = ref("..fEm_Gas");
              break;
            case "energy_source_oil":
              fEmEnergy = ref("..fEm_Oel");
              break;
            case "energy_source_biomass":
              fEmEnergy = ref("..fEm_Bio");
              break;
            case "energy_source_electricity":
              if (powerConsumptionSource == "power_consumption_source_mix") {
                fEmEnergy = ref("..fEm_Strom_Mix");
              } else if (powerConsumptionSource ==
                  "power_consumption_source_green") {
                fEmEnergy = ref("..fEm_Strom_Oeko");
              }
              break;
            case "energy_source_district_heating":
              fEmEnergy = ref("..fEm_FW");
              break;
            case "energy_source_other":
              fEmEnergy = ref("..fEm_Sonstiges");
              break;
          }

          // falls Raumwärme und Trinkwarmwasser getrennt sind
          if (isSeparatedHeatProvision) {
            switch (energySourceWater) {
              case "energy_source_water_gas":
                fEmEnergyWater = ref("..fEm_Gas");
                break;
              case "energy_source_water_oil":
                fEmEnergyWater = ref("..fEm_Oel");
                break;
              case "energy_source_water_biomass":
                fEmEnergyWater = ref("..fEm_Bio");
                break;
              case "energy_source_water_electricity":
                if (powerConsumptionSource == "power_consumption_source_mix") {
                  fEmEnergyWater = ref("..fEm_Strom_Mix");
                } else if (powerConsumptionSource ==
                    "power_consumption_source_green") {
                  fEmEnergyWater = ref("..fEm_Strom_Oeko");
                }
                break;
              case "energy_source_water_district_heating":
                fEmEnergyWater = ref("..fEm_FW");
                break;
              case "energy_source_water_other":
                fEmEnergyWater = ref("..fEm_Sonstiges");
                break;
            }

            // Umrechnungen für den Fall, dass Einheit anders ist als kWh
            if (heatingConsumptionUnitWater ==
                "annual_heat_consumption_water_unit_mwh") {
              heatingConsumptionWater *= 1000;
            } else if (heatingConsumptionUnitWater ==
                "annual_heat_consumption_water_unit_l") {
              heatingConsumptionWater /= 0.1;
            } else if (heatingConsumptionUnitWater ==
                "annual_heat_consumption_water_unit_kg") {
              heatingConsumptionWater /= 0.2;
            } else if (heatingConsumptionUnitWater ==
                "annual_heat_consumption_water_unit_m3") {
              if (energySourceWater == "energy_source_water_biomass") {
                heatingConsumptionWater *= 1000;
              } else {
                heatingConsumptionWater *= 10000;
              }
            }

            return (energyConsumption * fEmEnergy) +
                (heatingConsumptionWater * fEmEnergyWater);
          }

          return energyConsumption * fEmEnergy;
        })),

      //CO2 Emissionen Strom
      FormulaNode(
        (n) => n
          ..key = "power_emission"
          ..footprint(
            (input, ref) {
              var fEmElectricity = .0;
              var powerConsumptionSource =
                  input<String>("..power_consumption_source");
              var powerConsumption =
                  input<double>("..annual_power_consumption");

              var isSecondaryGenerationElectricity =
                  input<bool>("..secondary_generation_electricity");
              var secondaryGenerationElectricityPower = input<double>(
                  "..secondary_generation_electricity.secondary_generation_electricity_power");
              if (powerConsumptionSource == "power_consumption_source_mix") {
                fEmElectricity = ref("..fEm_Strom_Mix");
              } else if (powerConsumptionSource ==
                  "power_consumption_source_green") {
                fEmElectricity = ref("..fEm_Strom_Oeko");
              }

              if (isSecondaryGenerationElectricity) {
                powerConsumption -= secondaryGenerationElectricityPower;
              }

              return powerConsumption * fEmElectricity;
            },
          ),
      ),
    ],
  );

  b.footprint(
    (input, ref) {
      return (ref(".heat_emission") + ref(".power_emission")) /
          (input<double>(".people_in_household") * 1000);
    },
  );
}
