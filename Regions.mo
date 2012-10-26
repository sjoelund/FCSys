within FCSys;
package Regions "3D arrays of discrete, interconnected subregions"
  extends Modelica.Icons.Package;
  import Modelica.Media.IdealGases.Common.SingleGasesData;
  package Examples "Examples and tests"
    extends Modelica.Icons.ExamplesPackage;
    model FPToFP "Test one flow plate to the other"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      AnFPs.AnFP anFP(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each graphite('e-'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

      AnGDLs.AnGDL anGDL(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each graphite('e-'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

      AnCLs.AnCL anCL(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each ionomer('H+'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

      PEMs.PEM pEM(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      CaCLs.CaCL caCL(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each ionomer('H+'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));

      CaGDLs.CaGDL caGDL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));

      CaFPs.CaFP caFP(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-84,0})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={84,0})));

      FCSys.BCs.Face.Subregion0Current bC3[anFP.n_x, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-60,-24})));

      FCSys.BCs.Face.Subregion0Current bC4[anFP.n_x, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-60,24})));

      FCSys.BCs.Face.Subregion0Current bC5[caFP.n_x, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={60,-24})));
      FCSys.BCs.Face.Subregion0Current bC6[caFP.n_x, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={60,24})));
    initial equation
      anFP.subregions.graphite.'e-'.mu = anGDL.subregions.graphite.'e-'.mu;
      anGDL.subregions.graphite.'e-'.mu = anCL.subregions.graphite.'e-'.mu;
      anCL.subregions.ionomer.'H+'.mu = pEM.subregions.ionomer.'H+'.mu;
      pEM.subregions.ionomer.'H+'.mu = caCL.subregions.ionomer.'H+'.mu;

    equation
      connect(bC1.face, anFP.negativeX) annotation (Line(
          points={{-80,3.65701e-16},{-80,6.10623e-16},{-70,6.10623e-16}},
          color={127,127,127},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None));
      connect(anFP.positiveX, anGDL.negativeX) annotation (Line(
          points={{-50,6.10623e-16},{-50,6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(anGDL.positiveX, anCL.negativeX) annotation (Line(
          points={{-30,6.10623e-16},{-30,6.10623e-16}},
          color={240,0,0},
          smooth=Smooth.None,
          thickness=0.5));

      connect(anCL.positiveX, pEM.negativeX) annotation (Line(
          points={{-10,6.10623e-16},{-10,6.10623e-16}},
          color={240,0,0},
          smooth=Smooth.None,
          thickness=0.5));

      connect(pEM.positiveX, caCL.negativeX) annotation (Line(
          points={{10,6.10623e-16},{10,6.10623e-16},{10,6.10623e-16}},
          color={0,0,240},
          smooth=Smooth.None,
          thickness=0.5));

      connect(caCL.positiveX, caGDL.negativeX) annotation (Line(
          points={{30,6.10623e-16},{30,6.10623e-16}},
          color={0,0,240},
          smooth=Smooth.None,
          thickness=0.5));

      connect(caGDL.positiveX, caFP.negativeX) annotation (Line(
          points={{50,6.10623e-16},{50,6.10623e-16}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      connect(caFP.positiveX, bC2.face) annotation (Line(
          points={{70,6.10623e-16},{80,6.10623e-16},{80,1.23436e-15}},
          color={127,127,127},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC3.face, anFP.negativeY) annotation (Line(
          points={{-60,-20},{-60,-10}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bC4.face, anFP.positiveY) annotation (Line(
          points={{-60,20},{-60,10}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bC5.face, caFP.negativeY) annotation (Line(
          points={{60,-20},{60,-10}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bC6.face, caFP.positiveY) annotation (Line(
          points={{60,20},{60,10}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(graphics),
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.FPToFP.mos"),
        experiment(
          StopTime=20,
          Tolerance=1e-06,
          Algorithm="Dassl"),
        experimentSetupOutput);
    end FPToFP;

    model GDLToGDL "Test one GDL to the other"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      AnGDLs.AnGDL anGDL(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each graphite('e-'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

      AnCLs.AnCL anCL(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each graphite('e-'(Ndot_IC=0.1*U.A)),each ionomer('H+'(
                partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      // **temp e- Ndot_IC
      PEMs.PEM pEM(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each ionomer('H+'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      CaCLs.CaCL caCL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));

      CaGDLs.CaGDL caGDL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each gas(
          inclH2O=true,
          inclH2=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))), each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,0})));

      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))), each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={64,0})));

      inner FCSys.BCs.Defaults defaults(analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
    initial equation
      anGDL.subregions.graphite.'e-'.mu = anCL.subregions.graphite.'e-'.mu;
      anCL.subregions.ionomer.'H+'.mu = pEM.subregions.ionomer.'H+'.mu;
      pEM.subregions.ionomer.'H+'.mu = caCL.subregions.ionomer.'H+'.mu;

    equation
      connect(bC1.face, anGDL.negativeX) annotation (Line(
          points={{-60,3.65701e-16},{-50,6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(anGDL.positiveX, anCL.negativeX) annotation (Line(
          points={{-30,6.10623e-16},{-30,6.10623e-16}},
          color={240,0,0},
          smooth=Smooth.None,
          thickness=0.5));

      connect(anCL.positiveX, pEM.negativeX) annotation (Line(
          points={{-10,6.10623e-16},{-10,6.10623e-16}},
          color={240,0,0},
          smooth=Smooth.None,
          thickness=0.5));

      connect(pEM.positiveX, caCL.negativeX) annotation (Line(
          points={{10,6.10623e-16},{10,6.10623e-16},{10,6.10623e-16}},
          color={0,0,240},
          smooth=Smooth.None,
          thickness=0.5));

      connect(caCL.positiveX, caGDL.negativeX) annotation (Line(
          points={{30,6.10623e-16},{30,6.10623e-16}},
          color={0,0,240},
          smooth=Smooth.None,
          thickness=0.5));

      connect(caGDL.positiveX, bC2.face) annotation (Line(
          points={{50,6.10623e-16},{56,0},{60,1.23436e-15}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        Diagram(graphics),
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.GDLToGDL.mos"),
        experiment(
          StopTime=30,
          Tolerance=1e-06,
          Algorithm="Dassl"),
        experimentSetupOutput);
    end GDLToGDL;

    model CLToCL "Test one catalyst layer to the other"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);

      AnCLs.AnCL anCL(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each ionomer('H+'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

      PEMs.PEM pEM(
        final L_y=L_y,
        final L_z=L_z,
        subregions(each ionomer('H+'(partNumInitMeth=InitMethScalar.None))))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      CaCLs.CaCL caCL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](
        each ionomer(
          'inclH+'=false,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T))),
        each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T))),
        each gas(
          inclH2O=true,
          inclH2=false,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-44,-8.88178e-16})));

      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](
        each ionomer(
          'inclH+'=false,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T))),
        each gas(
          inclH2O=true,
          inclN2=false,
          inclO2=false,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),
        each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={44,0})));

      inner FCSys.BCs.Defaults defaults(analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
    initial equation
      anCL.subregions.ionomer.'H+'.mu = pEM.subregions.ionomer.'H+'.mu;
      pEM.subregions.ionomer.'H+'.mu = caCL.subregions.ionomer.'H+'.mu;

    equation
      connect(bC1.face, anCL.negativeX) annotation (Line(
          points={{-40,3.65701e-16},{-35,3.65701e-16},{-35,6.10623e-16},{-30,
              6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(anCL.positiveX, pEM.negativeX) annotation (Line(
          points={{-10,6.10623e-16},{-10,6.10623e-16}},
          color={240,0,0},
          smooth=Smooth.None,
          thickness=0.5));
      connect(pEM.positiveX, caCL.negativeX) annotation (Line(
          points={{10,6.10623e-16},{10,-3.36456e-22},{10,6.10623e-16},{10,
              6.10623e-16}},
          color={0,0,240},
          smooth=Smooth.None,
          thickness=0.5));

      connect(caCL.positiveX, bC2.face) annotation (Line(
          points={{30,6.10623e-16},{40,1.23436e-15}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        Diagram(graphics),
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.CLToCL.mos"),
        experiment(
          StopTime=25,
          Tolerance=1e-06,
          Algorithm="Dassl"),
        experimentSetupOutput);
    end CLToCL;

    model AnFP "Test the anode flow plate"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      AnFPs.AnFP anFP(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-84,0})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-36,0})));

      FCSys.BCs.Face.Subregion0Current bC3[anFP.n_x, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-60,-24})));
      FCSys.BCs.Face.Subregion0Current bC4[anFP.n_x, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-60,24})));

    equation
      connect(bC1.face, anFP.negativeX) annotation (Line(
          points={{-80,3.65701e-16},{-80,6.10623e-16},{-70,6.10623e-16}},
          color={127,127,127},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC2.face, anFP.positiveX) annotation (Line(
          points={{-40,1.23436e-15},{-40,6.10623e-16},{-50,6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC3.face, anFP.negativeY) annotation (Line(
          points={{-60,-20},{-60,-10}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bC4.face, anFP.positiveY) annotation (Line(
          points={{-60,20},{-60,10}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(graphics),
        experiment(Tolerance=1e-06,StopTime=10),
        experimentSetupOutput,
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.AnFP.mos"));
    end AnFP;

    model AnGDL "Test the anode gas diffusion layer"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;
      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      AnGDLs.AnGDL anGDL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))), each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-64,0})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))), each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-16,0})));

    equation
      connect(bC1.face, anGDL.negativeX) annotation (Line(
          points={{-60,3.65701e-16},{-60,6.10623e-16},{-50,6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(anGDL.positiveX, bC2.face) annotation (Line(
          points={{-30,6.10623e-16},{-20,6.10623e-16},{-20,1.23436e-15}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        Diagram(graphics),
        experiment(Tolerance=1e-06,StopTime=10),
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.AnGDL.mos"));
    end AnGDL;

    model AnCL "Test the anode catalyst layer"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      AnCLs.AnCL anCL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](
        each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),
        each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T))),
        each ionomer(
          inclC19HF37O5S=true,
          'inclH+'=true,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-44,-8.88178e-16})));

      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](
        each gas(
          inclH2=true,
          inclH2O=true,
          H2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),
        each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T))),
        each ionomer(
          inclC19HF37O5S=true,
          'inclH+'=true,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={4,0})));

    equation
      connect(bC1.face, anCL.negativeX) annotation (Line(
          points={{-40,3.65701e-16},{-40,6.10623e-16},{-30,6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(anCL.positiveX, bC2.face) annotation (Line(
          points={{-10,6.10623e-16},{-2,6.10623e-16},{-2,1.23436e-15},{
              6.66134e-16,1.23436e-15}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(
          StopTime=0.7,
          NumberOfIntervals=5000,
          Tolerance=1e-06),
        experimentSetupOutput,
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.AnCL.mos"));
    end AnCL;

    model PEM "Test the proton exchange membrane"

      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);

      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      PEMs.PEM pEM(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each gas(inclH2O=true, H2O(
              entropySpec(k=defaults.T))), each ionomer(
          inclC19HF37O5S=false,
          'inclH+'=false,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-24,-8.88178e-16})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each gas(inclH2O=true, H2O(
              entropySpec(k=defaults.T))), each ionomer(
          inclC19HF37O5S=false,
          'inclH+'=false,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={24,0})));
    equation
      connect(bC1.face, pEM.negativeX) annotation (Line(
          points={{-20,3.65701e-16},{-20,6.10623e-16},{-10,6.10623e-16}},
          color={240,0,0},
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC2.face, pEM.positiveX) annotation (Line(
          points={{20,1.23436e-15},{10,1.23436e-15},{10,6.10623e-16}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        Diagram(graphics),
        experiment(Tolerance=1e-06,StopTime=10),
        experimentSetupOutput,
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.PEM.mos"));
    end PEM;

    model CaCL "Test the cathode catalyst layer"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));

      CaCLs.CaCL caCL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](
        each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),
        each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T))),
        each ionomer(
          inclC19HF37O5S=true,
          'inclH+'=true,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-4,-8.88178e-16})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](
        each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),
        each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T))),
        each ionomer(
          inclC19HF37O5S=true,
          'inclH+'=true,
          C19HF37O5S(entropySpec(k=defaults.T)),
          'H+'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={44,0})));

    equation
      connect(bC1.face, caCL.negativeX) annotation (Line(
          points={{6.66134e-16,3.65701e-16},{10,3.65701e-16},{10,6.10623e-16}},

          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC2.face, caCL.positiveX) annotation (Line(
          points={{40,1.23436e-15},{40,6.10623e-16},{30,6.10623e-16}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics),
        experiment(
          StopTime=500,
          Tolerance=1e-06,
          Algorithm="Dassl"),
        experimentSetupOutput,
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.CaCL.mos"));
    end CaCL;

    model CaGDL "Test the cathode gas diffusion layer"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;
      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      CaGDLs.CaGDL caGDL(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))), each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={16,-8.88178e-16})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))), each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={64,0})));

    equation
      connect(bC1.face, caGDL.negativeX) annotation (Line(
          points={{20,3.65701e-16},{20,6.10623e-16},{30,6.10623e-16}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC2.face, caGDL.positiveX) annotation (Line(
          points={{60,1.23436e-15},{65,1.23436e-15},{65,6.10623e-16},{50,
              6.10623e-16}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      annotation (
        experiment(StopTime=10, Tolerance=1e-06),
        Diagram(graphics),
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.CaGDL.mos"));
    end CaGDL;

    model CaFP "Test the cathode flow plate"
      import FCSys.Subregions.Phases;
      extends Modelica.Icons.Example;

      parameter Q.Length L_y[:]=fill(1*U.m/1, 1)
        "<html>Lengths along the channel (<i>L</i><sub>y</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      parameter Q.Length L_z[:]=fill(5*U.mm/1, 1)
        "<html>Lengths across the channel (<i>L</i><sub>z</sub>)</html>"
        annotation (Dialog(group="Geometry"));
      final parameter Integer n_y=size(L_y, 1)
        "Number of regions along the channel" annotation (HideResult=true);
      final parameter Integer n_z=size(L_z, 1)
        "Number of regions across the channel" annotation (HideResult=true);
      inner FCSys.BCs.Defaults defaults(
        p=149.6*U.kPa,
        T=333.15*U.K,
        analysis=true)
        annotation (Placement(transformation(extent={{70,70},{90,90}})));
      CaFPs.CaFP caFP(final L_y=L_y, final L_z=L_z)
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));

      FCSys.BCs.Face.Subregion0Current bC1[n_y, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)),
          H2O(entropySpec(k=defaults.T))),each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={36,0})));
      FCSys.BCs.Face.Subregion0Current bC2[n_y, n_z](each graphite(
          inclC=true,
          'incle-'=true,
          C(entropySpec(k=defaults.T)),
          'e-'(entropySpec(k=defaults.T)))) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={84,0})));
      FCSys.BCs.Face.Subregion0Current bC3[caFP.n_x, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          H2O(entropySpec(k=defaults.T)),
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={60,-24})));
      FCSys.BCs.Face.Subregion0Current bC4[caFP.n_x, n_z](each gas(
          inclH2O=true,
          inclN2=true,
          inclO2=true,
          H2O(entropySpec(k=defaults.T)),
          N2(entropySpec(k=defaults.T)),
          O2(entropySpec(k=defaults.T)))) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={60,24})));
    equation
      connect(bC1.face, caFP.negativeX) annotation (Line(
          points={{40,3.65701e-16},{42,3.65701e-16},{42,6.10623e-16},{50,
              6.10623e-16}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));

      connect(caFP.positiveX, bC2.face) annotation (Line(
          points={{70,6.10623e-16},{80,6.10623e-16},{80,1.23436e-15}},
          color={127,127,127},
          pattern=LinePattern.None,
          thickness=0.5,
          smooth=Smooth.None));

      connect(bC3.face, caFP.negativeY) annotation (Line(
          points={{60,-20},{60,-10}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));
      connect(bC4.face, caFP.positiveY) annotation (Line(
          points={{60,20},{60,10}},
          color={0,0,240},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (
        Diagram(graphics),
        experiment(StopTime=10, Tolerance=1e-06),
        experimentSetupOutput,
        Commands(file(ensureSimulated=true) =
            "resources/scripts/Dymola/Regions.Examples.CaFP.mos"));
    end CaFP;
  end Examples;

  package AnFPs "Anode flow plates"
    extends Modelica.Icons.Package;
    model AnFP "Anode flow plate"
      //extends FCSys.BaseClasses.Icons.Names.Top4;

      extends FCSys.Regions.Region(
        L_x=fill(8*U.mm/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        final inclYFaces=true,
        inclZFaces=false,
        redeclare FCSys.Subregions.SubregionNoIonomer subregions[n_x, n_y, n_z]
          (
          each inclReact=false,
          each graphite(
            inclC=true,
            'incle-'=true,
            C(V_IC=V - xV),
            'e-'(
              final epsilon=0,
              setXVel=true,
              setYVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setTemp=true)),
          each gas(
            inclH2=true,
            inclH2O=true,
            H2O(
              setXVel=true,
              p_IC=defaults.y_H2O*defaults.p,
              negativeX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
              positiveX(matEntOpt=MaterialEntropyOpt.OpenDiabatic),
              negativeY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false),
              positiveY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false)),
            H2(
              setXVel=true,
              p_IC=(1 - defaults.y_H2O)*defaults.p,
              negativeX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
              positiveX(matEntOpt=MaterialEntropyOpt.OpenDiabatic),
              negativeY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false),
              positiveY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false)))));

      parameter Q.NumberAbsolute x(nominal=1) = 0.1 "Volumetric porosity";

    protected
      final parameter Q.Volume xV=x*V "Gas volume";

      // The specific heat capacity at constant pressure and thermal
      // resistivity is based on data of graphite fiber epoxy (25% vol)
      // composite (heat flow parallel to fibers) at 300 K from Incropera and
      // DeWitt (2002, p. 909).  See FCSys.Subregions.Species.C.Fixed for more
      // data.

      // Thermal resistivity of some other flowplate materials from Incropera
      // and DeWitt (2002, pp. 905 & 907):
      //                                   Stainless steel
      //                                   ------------------------------------------------------------------------------------
      //             Aluminum (pure)       AISI 302              AISI 304              AISI 316              AISI 347
      //             ------------------    ------------------    ------------------    ------------------    ------------------
      //             c0*U.kg    alpha_S    c0*U.kg    alpha_S    c0*U.kg    alpha_S    c0*U.kg    alpha_S    c0*U.kg    alpha_S
      //             *U.K       *U.W       *U.K       *U.W       *U.K       *U.W       *U.K       *U.W       *U.K       *U.W
      //             /(U.J      /(U.m      /(U.J      /(U.m      /(U.J      /(U.m      /(U.J      /(U.m      /(U.J      /(U.m
      //     T/K     *m)        *U.K)      *m)        *U.K)      *m)        *U.K)      *m)        *U.K)      *m)        *U.K)
      //     ----    -------    -------    -------    -------    -------    -------    -------    -------    -------    -------
      //     100     482        1/302                            272        1/9.2
      //     200     798        1/237                            402        1/12.6
      //     300     903        1/237      480        1/15.1     477        1/14.9     468        1/13.4     480        1/14.2
      //     400     949        1/240      512        1/17.3     515        1/16.6     504        1/15.2     513        1/15.8
      //     600     1033       1/231      559        1/20.0     557        1/19.8     550        1/18.3     559        1/18.9
      //     800     1146       1/218      585        1/22.8     582        1/22.6     576        1/21.3     585        1/21.9
      //     1000                          606        1/25.4     611        1/25.4     602        1/24.2     606        1/24.7

      // Electrical resistivities:
      //     Aluminum (http://en.wikipedia.org/wiki/Electrical_resistivity, 2008):
      //         2.82e-8 ohm.m
      //     Graphite (http://hypertextbook.com/facts/2004/AfricaBelgrave.shtml):
      //         7.837e-6 to 41e-6 ohm.m
      //     Copper (http://en.wikipedia.org/wiki/Electrical_resistivity, 2008):
      //         1.72e-8 ohm.m
      //     Stainless steel AISI 304 (http://hypertextbook.com/facts/2006/UmranUgur.shtml, 2008):
      //         6.897e-7 ohm.m
      //     Entegris/Poco Graphite AXM-5Q [Entegris2012]:
      //         1.470e-5 ohm.m

      // Dynamic viscosities:
      //     Air at 1 atm [Incropera2002, p. 917, Table A.4]:
      //         @ 300K:  1.846e-5 Pa.s
      //         @ 350K:  2.082e-5 Pa.s
      //     Liquid H2O [Incropera2002, p. 924, Table A.6]:
      //         @ 300K, 0.03531 bar (saturation pressure): 8.55e-4 Pa.s
      //         @ 350K, 0.4163 bar (saturation pressure): 3.65e-4 Pa.s
      //     Gas H2O [Incropera2002, p. 924, Table A.6]:
      //         @ 300K, 0.03531 bar (saturation pressure): 9.09e-6 Pa.s
      //         @ 350K, 0.4163 bar (saturation pressure): 1.109e-5 Pa.s

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage and transport of chemical/electrochemical
species in and through the anode flow plate of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
and the y axis extends along the length of the channel. The model is
bidirectional, so that either <code>negativeY</code> or <code>positiveY</code> can be
used as the inlet. The z axis extends across the width of the channel.</p></html>"),

        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-76.648,66.211},{-119.073,52.0689}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  rotation=45,
                  fillColor={135,135,135},
                  origin={111.017,77.3801},
                  pattern=LinePattern.None,
                  lineColor={95,95,95}),Rectangle(
                  extent={{-20,40},{0,-60}},
                  lineColor={95,95,95},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Polygon(
                  points={{20,0},{42,0},{42,80},{-42,80},{-42,0},{-20,0},{-20,
                40},{0,60},{20,60},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{20,0},{42,0},{42,-80},{-42,-80},{-42,0},{-20,0},{-20,
                -60},{0,-60},{20,-40},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(extent={{-20,40},{0,-60}},
              lineColor={0,0,0}),Polygon(
                  points={{-20,40},{0,60},{20,60},{0,40},{-20,40}},
                  lineColor={0,0,0},
                  smooth=Smooth.None),Polygon(
                  points={{20,60},{0,40},{0,-60},{20,-40},{20,60}},
                  lineColor={0,0,0},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{16,48},{4,36},{4,32},{14,42},{14,36},{4,26},{4,12},{
                16,24},{16,28},{6,18},{6,24},{16,34},{16,48}},
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Polygon(
                  points={{16,28},{4,16},{4,12},{14,22},{14,16},{4,6},{4,-8},{
                16,4},{16,8},{6,-2},{6,4},{16,14},{16,28}},
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Polygon(
                  points={{16,8},{4,-4},{4,-8},{14,2},{14,-4},{4,-14},{4,-28},{
                16,-16},{16,-12},{6,-22},{6,-16},{16,-6},{16,8}},
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Polygon(
                  points={{16,-12},{4,-24},{4,-28},{14,-18},{14,-24},{4,-34},{4,
                -48},{16,-36},{16,-32},{6,-42},{6,-36},{16,-26},{16,-12}},
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Line(
                  points={{10,0},{100,0}},
                  color={240,0,0},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{-20,0},{-100,0}},
                  color={127,127,127},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{0,-60},{0,-100}},
                  color={240,0,0},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={240,0,0},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={240,0,0},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Ellipse(
                  extent={{-4,52},{4,48}},
                  lineColor={135,135,135},
                  fillColor={240,0,0},
                  visible=inclYFaces,
                  fillPattern=FillPattern.Sphere),Line(
                  points={{0,100},{0,50}},
                  color={240,0,0},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}),
        Diagram(graphics));
    end AnFP;

    model GM "General Motors cathodic test flow plate and current collector"
      extends AnFP(
        subregions(each graphite(C(alpha_S=U.m*U.K/(95*U.W), beta_S=U.m*U.K/(95
                  *U.W)))),
        L_x=fill(35.22*U.mm/1, 1),
        L_y=fill(1.543*U.m, 1),
        L_z=fill((5/1.543)*U.mm, 1),
        x=0.011);

      annotation (Documentation(info="<html>
  <p>Assumptions:<ol>
<li>The x-axis length of this region is the thickness
of the GM-compatible <a href=\"modelica://FCSys/resources/documentation/Regions/AnFPs/GM/Flow field.pdf\">flow field</a>,
<a href=\"modelica://FCSys/resources/documentation/Regions/AnFPs/GM/Current collector plate.pdf\">current collector plate</a>,
 and end plate combined.  The material properties are those of epoxy-filled
graphite, although the current collector is actually gold-plated copper and the end plate is actually aluminum.</li>
<li>The y-axis length of this region is the length of the double-serpentine flow channels of the
GM-compatible
anode <a href=\"modelica://FCSys/resources/documentation/Regions/AnFPs/GM/Flow field.pdf\">flow field</a> as if they were straightened.</li>
<li>The z-axis length of this region is 50 cm<sup>2</sup> divided by the y-axis length.  Only the active area
(50 cm<sup>2</sup>) is modeled&mdash;not the entire area (100 cm<sup>2</sup>).
<li>It is assumed that the solid (graphite/epoxy composite) constitutes the entire volume except for the flow channels.
In reality, there are cut-outs and holes for thermocouples, hardware, etc.</li>
</ol></p>
<p>Additional notes:
<ul>
<li>The default thermal resistivity ((1/95) m K/W) is that of Entegris/Poco Graphite AXM-5Q
[<a href=\"modelica://FCSys.UsersGuide.References\">Entegris2012</a>].</li>
</ul>
</p>
</html>"));
    end GM;
  end AnFPs;

  package AnGDLs "Anode gas diffusion layers"
    extends Modelica.Icons.Package;
    model AnGDL "Anode gas diffusion layer"
      //extends FCSys.BaseClasses.Icons.Names.Top4;
      // Note:  Extensions of AnGDL should be placed directly in the AnGDLs
      // package rather than nested packages (e.g., by manufacturer) so that
      // __Dymola_choicesFromPackage can be used.  In Dymola 7.4, the
      // parameter dialogs launch too slowly when __Dymola_choicesAllMatching
      // is used.
      extends FCSys.Regions.Region(
        L_x=fill(0.3*U.mm/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        inclYFaces=false,
        inclZFaces=false,
        redeclare FCSys.Subregions.SubregionNoIonomer subregions[n_x, n_y, n_z]
          (
          each inclReact=false,
          each gas(
            inclH2=true,
            inclH2O=true,
            H2(
              setXVel=true,
              p_IC=(1 - defaults.y_H2O)*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false)),
            H2O(
              setXVel=true,
              p_IC=defaults.y_H2O*defaults.p,
              negativeY(viscousX=false))),
          each graphite(
            inclC=true,
            'incle-'=true,
            C(V_IC=V - xV),
            'e-'(
              final epsilon=0,
              setXVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setTemp=true))));

      parameter Q.NumberAbsolute x(nominal=1) = 0.76 "Volumetric porosity";
      // The default porosity is for Sigracet 24 BC.
      // Note:  The diffusion coefficients for species that are transported
      // through the pores (e.g., gases) are adjusted by a factor of
      // x^(2/3), where the power of 2/3 converts the volumetric porosity to
      // areic porosity.  The diffusion coefficient for the species that is
      // transported through the solid (electrons) is adjusted by a factor of
      // (1 - x)^(2/3).  This is contrary to Weber and Newman [Weber2004, p. 4696,
      // Eq. 38], who use a factor of (1 - x)^(3/2).
      // Note:  Porosity may be lower once assembled (and compressed).  Bernardi
      // and Verbrugge give x = 0.4 [Bernardi1992, p. 2483, Table 3].
    protected
      final parameter Q.Volume xV=x*V "Gas volume";

      // Thermal conductivity of solid (excluding the effect of porosity)
      // Compressed SGL Sigracet 10 BA GDL: k = 1.18 +/- 0.11 W/(m.K) at room temperature (i.e., 298.15 K) [Nitta2008]
      // Teflon: 0.35 W/(m.K) at 300 K [Incropera2002, p. 916]
      // Teflon: 0.45 W/(m.K) at 400 K [Incropera2002, p. 916]

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage and transport of
chemical/electrochemical species in and through the anode gas diffusion layer of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
The y axis extends along the length of the channel and
the z axis extends across the width of the channel.</p></html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-78.7855,18.6813},{-50.5004,-23.7455}},
                  lineColor={64,64,64},
                  fillColor={127,127,127},
                  rotation=-45,
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={42.5001,11.0805}),Rectangle(
                  extent={{-40,40},{0,-60}},
                  lineColor={64,64,64},
                  fillColor={127,127,127},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{20,0},{42,0},{42,80},{-42,80},{-42,0},{-20,0},{-20,
                40},{0,60},{20,60},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{20,0},{42,0},{42,-80},{-42,-80},{-42,0},{-20,0},{-20,
                -60},{0,-60},{20,-40},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{0,40},{20,60},{20,-40},{0,-60},{0,40}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Solid,
                  fillColor={64,64,64}),Rectangle(extent={{-20,40},{0,-60}},
              lineColor={0,0,0}),Polygon(
                  points={{0,60},{20,60},{0,40},{-20,40},{0,60}},
                  lineColor={0,0,0},
                  smooth=Smooth.None),Line(
                  points={{-20,0},{-100,0}},
                  color={240,0,0},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{10,0},{100,0}},
                  color={240,0,0},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{0,-60},{0,-100}},
                  color={240,0,0},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={240,0,0},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={240,0,0},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={240,0,0},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}),
        Diagram(graphics));
    end AnGDL;

    model Sigracet10BA "<html>SGL Carbon Group Sigracet&reg; 10 BA</html>"
      extends AnGDL(L_x=fill(0.400*U.mm/1, 1),x=0.88);
      // See [SGL2007]:
      //     Diffusivity: L = 0.400 mm, p = 0.85 m/s (for air) => D = P*L = 340 mm2/s
      //     Density: (85 g/m2)/(0.400 mm)/0.88 = 212.5 kg/m3
      //     Electronic resistivity: (12 mohm.cm2)/(0.400 mm) = 3 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
    <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet10BA;

    model Sigracet10BB "<html>SGL Carbon Group Sigracet&reg; 10 BB</html>"
      extends AnGDL(L_x=fill(0.420*U.mm/1, 1),x=0.84);
      // See [SGL2007]:
      //     Diffusivity: L = 0.420 mm, p = 0.03 m/s (for air) => D = P*L = 12.6 mm2/s
      //     Density: (125 g/m2)/(0.420 mm) = 297.62 kg/m3
      //     Electronic resistivity: (15 mohm.cm2)/(0.420 mm) = 3.5714 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet10BB;

    model Sigracet10BC "<html>SGL Carbon Group Sigracet&reg; 10 BC</html>"
      extends AnGDL(L_x=fill(0.420*U.mm/1, 1),x=0.82);
      // See [SGL2007]:
      //     Diffusivity: L = 0.420 mm, p = 0.0145 m/s (for air) => D = P*L = 6.09 mm2/s
      //     Density: (135 g/m2)/(0.420 mm) = 321.43 kg/m3
      //     Electronic resistivity: (16 mohm.cm2)/(0.420 mm) = 3.8095 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet10BC;

    model Sigracet24BA "<html>SGL Carbon Group Sigracet&reg; 24 BA</html>"
      extends AnGDL(L_x=fill(0.190*U.mm/1, 1),x=0.84);
      // See [SGL2007]:
      //     Diffusivity: L = 0.190 mm, p = 0.30 m/s (for air) => D = P*L = 57 mm2/s
      //     Density: (54 g/m2)/(0.190 mm) = 284.21 kg/m3
      //     Electronic resistivity: (10 mohm.cm2)/(0.190 mm) = 5.2632 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet24BA;

    model Sigracet24BC "<html>SGL Carbon Group Sigracet&reg; 24 BC</html>"
      extends AnGDL(L_x=fill(0.235*U.mm/1, 1),x=0.76);
      // See [SGL2007]:
      //     Diffusivity: L = 0.235 mm, p = 0.0045 m/s (for air) => D = P*L = 1.0575 mm2/s
      //     Density: (100 g/m2)/(0.235 mm) = 425.53 kg/m3
      //     Electronic resistivity: (11 mohm.cm2)/(0.235 mm) = 4.6809 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet24BC;

    model Sigracet25BA "<html>SGL Carbon Group Sigracet&reg; 25 BA</html>"
      extends AnGDL(L_x=fill(0.190*U.mm/1, 1),x=0.88);
      // See [SGL2007]:
      //     Diffusivity: L = 0.190 mm, p = 0.90 m/s (for air) => D = P*L = 171 mm2/s
      //     Density: (40 g/m2)/(0.190 mm) = 210.53 kg/m3
      //     Electronic resistivity: (10 mohm.cm2)/(0.190 mm) = 5.2632 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet25BA;

    model Sigracet25BC "<html>SGL Carbon Group Sigracet&reg; 25 BC</html>"
      extends AnGDL(L_x=fill(0.235*U.mm/1, 1),x=0.80);
      // See [SGL2007]:
      //     Diffusivity: L = 0.235 mm, p = 0.008 m/s (for air) => D = P*L = 1.88 mm2/s
      //     Density: (86 g/m2)/(0.235 mm) = 365.96 kg/m3
      //     Electronic resistivity: (12 mohm.cm2)/(0.235 mm) = 5.1064 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end Sigracet25BC;

    model TorayTGPH030 "Toray Industries TGP-H-030"
      extends AnGDL(L_x=fill(0.110*U.mm/1, 1),x=0.80);
      // See [Toray2010]:
      //     Diffusivity: L = 0.110 mm, P/p = 2500 ml.mm/(cm2.hr.mmAq) = 0.70814e-3 m/(s.kPa)
      //         => D = P*L = 7.89e-6 m2/s, assuming p = 101.325 kPa
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): not listed
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end TorayTGPH030;

    model TorayTGPH060 "Toray Industries TGP-H-060"
      extends AnGDL(L_x=fill(0.190*U.mm/1, 1),x=0.78);
      // See [Toray2010]:
      //     Diffusivity: L = 0.190 mm, P/p = 1900 ml.mm/(cm2.hr.mmAq) = 0.53818e-3 m/(s.kPa)
      //         => D = P*L = 10.36e-6 m2/s, assuming p = 101.325 kPa
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): 5.8 mohm.cm
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end TorayTGPH060;

    model TorayTGPH090 "Toray Industries TGP-H-090"
      extends AnGDL(L_x=fill(0.280*U.mm/1, 1),x=0.78);
      // See [Toray2010]:
      //     Diffusivity: L = 0.280 mm, P/p = 1700 ml.mm/(cm2.hr.mmAq) = 0.48153e-3 m/(s.kPa)
      //         => D = P*L = 13.66e-6 m2/s, assuming p = 101.325 kPa
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): 5.6 mohm.cm
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end TorayTGPH090;

    model TorayTGPH120 "Toray Industries TGP-H-030"
      extends AnGDL(L_x=fill(0.370*U.mm/1, 1),x=0.78);
      // See [Toray2010]:
      //     Diffusivity: L = 0.370 mm, P/p = 1500 ml.mm/(cm2.hr.mmAq) = 0.42488e-3 m/(s.kPa)
      //         => D = P*L = 15.93e-6 m2/s, assuming p = 101.325 kPa");
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): 4.7 mohm.cm
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="anGDL",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> model.</p></html>"));
    end TorayTGPH120;
  end AnGDLs;

  package AnCLs "Anode catalyst layers"
    extends Modelica.Icons.Package;
    model AnCL "Anode catalyst layer"
      //extends FCSys.BaseClasses.Icons.Names.Top4;

      extends FCSys.Regions.Region(
        L_x=fill(28.7*U.micro*U.m/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        inclYFaces=false,
        inclZFaces=false,
        redeclare FCSys.Subregions.Subregion subregions[n_x, n_y, n_z](
          each gas(
            inclH2=true,
            inclH2O=true,
            H2(
              p_IC=(1 - defaults.y_H2O)*defaults.p,
              setXVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false)),
            H2O(
              p_IC=defaults.y_H2O*defaults.p,
              setXVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false))),
          each graphite(
            inclC=true,
            'incle-'=true,
            C(V_IC=(V - xV)/2),
            'e-'(
              partNumInitMeth=InitMethScalar.ReactionRate,
              Ndot_IC=0*U.A,
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setXVel=true)),
          each ionomer(
            inclC19HF37O5S=true,
            'inclH+'=true,
            C19HF37O5S(V_IC=(V - xV)/2),
            'H+'(
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setXVel=true))));

      //'e-'( positiveX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
      //'H+'negativeX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),

      //alpha_Phi=1e-4*subregions[1,1,1].gas.H2.Data.beta()),
      // **Note assumption:  1/2 of solid is graphite, 1/2 is ionomer

      //'H+'(partNumInitMeth=InitMethScalar.VolumeSpecific, v_IC=U.L/(0.95*U.mol)))));

      //, 'e-'(alpha_N=1e49*
      //        FCSys.Characteristics.'e-'.gas.beta())),
      //each ionomer(C19HF37O5S(V_IC=0.15*V), 'H+'(alpha_N=1e49*
      //         FCSys.Characteristics.'e-'.gas.beta())))

      //partNumInitMeth=InitMethScalar.VolumeSpecific,
      //v_IC=U.L/(0.95*U.mol)

      parameter Q.NumberAbsolute x(nominal=1) = 0.25 "Volumetric porosity";
      parameter Q.NumberAbsolute lambda_IC=14
        "<html>Initial molar ratio of H<sub>2</sub>O to SO<sub>3</sub>H (&lambda;<sub>IC</sub>)</html>"
        annotation (Dialog(group="Initialization"));

    protected
      final parameter Q.Volume xV=x*V "Gas volume";

      // TODO: Add H2O to the ionomer according to lambda_IC.
      // TODO: Include reaction to absorb H2O into ionomer.
      // Assume zero volume of H2O in the ionomer?

      // TODO: Clean up (move to Species models if appropriate):

      // Volumic density of free protons from [Spry2009, p. 10214]:
      //   @ lambda = 12: 0.95 M
      //   @ lambda = 22: 0.54 M
      // where lambda is the ratio of water molecules to sulfonic acid units.

      // The default total thickness (sum(L_x)), 28.7*U.micro*U.m, is from [Gurau1998].
      //     SGL Sigracet 10 BA GDL: L=0.400 mm, P=0.85 m/s (for air) [SGL2007] => D = P*L = 340e-6 m2/s
      //     SGL Sigracet 10 BB GDL: L=0.420 mm, P=0.03 m/s (for air) [SGL2007] => D = P*L = 12.6e-6 m2/s
      //     SGL Sigracet 10 BC GDL: L=0.420 mm, P=0.0145 m/s (for air) [SGL2007] => D = P*L = 6.09e-6 m2/s
      //     SGL Sigracet 24 BA GDL: L=0.190 mm, P=0.30 m/s (for air) [SGL2004] => D = P*L = 57e-6 m2/s
      //     SGL Sigracet 24 BC GDL: L=0.235 mm, P=0.0045 m/s (for air) [SGL2004] => D = P*L = 1.0575e-6 m2/s
      //     SGL Sigracet 25 BA GDL: L=0.190 mm, P=0.90 m/s (for air) [SGL2004] => D = P*L = 171e-6 m2/s
      //     SGL Sigracet 25 BC GDL: L=0.235 mm, P=0.008 m/s (for air) [SGL2004] => D = P*L = 1.88e-6 m2/s
      //     Toray TGP-H-030: L=0.110 mm, P/p=2500 ml.mm/(cm2.hr.mmAq) = 0.70814e-3 m/(s.kPa) [Toray2010] => D = P*L = 7.89e-6 m2/s, assuming p=101.325 kPa
      //     Toray TGP-H-060: L=0.190 mm, P/p=00 ml.mm/(cm2.hr.mmAq) = 0.53818e-3 m/(s.kPa) [Toray2010] => D = P*L = 10.36e-6 m2/s, assuming p=101.325 kPa
      //     Toray TGP-H-090: L=0.280 mm, P/p=00 ml.mm/(cm2.hr.mmAq) = 0.48153e-3 m/(s.kPa) [Toray2010] => D = P*L = 13.66e-6 m2/s, assuming p=101.325 kPa
      //     Toray TGP-H-120: L=0.370 mm, P/p=00 ml.mm/(cm2.hr.mmAq) = 0.42488e-3 m/(s.kPa) [Toray2010] => D = P*L = 15.93e-6 m2/s, assuming p=101.325 kPa");

      // GDL porosity (ratio of pore volume to total volume), &epsilon;
      //     SGL Sigracet 10 BA GDL: 0.88 [SGL2007]
      //     SGL Sigracet 10 BB GDL: 0.84 [SGL2007]
      //     SGL Sigracet 10 BC GDL: 0.82 [SGL2007]
      //     SGL Sigracet 24 BA GDL: 0.84 [SGL2004]
      //     SGL Sigracet 24 BC GDL: 0.76 [SGL2004]
      //     SGL Sigracet 25 BA GDL: 0.88 [SGL2004]
      //     SGL Sigracet 25 BC GDL: 0.80 [SGL2004]
      //     0.4 [Bernardi1992, p. 2483, Table 3]

      // Density of the GDL material (excluding pore volume), &rho;<sub>GDL</sub>
      //     SGL Sigracet 10 BA GDL: (85 g/m2)/(0.400 mm)/0.88 = 241 kg/m3, based on areic weight, thickness, and porosity from [SGL2007]
      //     SGL Sigracet 10 BB GDL: (125 g/m2)/(0.420 mm)/0.84 = 354 kg/m3, based on areic weight, thickness, and porosity from [SGL2007]
      //     SGL Sigracet 10 BC GDL: (135 g/m2)/(0.420 mm)/0.82 = 392 kg/m3, based on areic weight, thickness, and porosity from [SGL2007]
      //     SGL Sigracet 24 BA GDL: (54 g/m2)/(0.190 mm)/0.84 = 711 kg/m3, based on areic weight, thickness, and porosity from [SGL2004]
      //     SGL Sigracet 24 BC GDL: (100 g/m2)/(0.235 mm)/0.76 = 560 kg/m3, based on areic weight, thickness, and porosity from [SGL2004]
      //     SGL Sigracet 25 BA GDL: (40 g/m2)/(0.190 mm)/0.88 = 239 kg/m3, based on areic weight, thickness, and porosity from [SGL2004]
      //     SGL Sigracet 25 BC GDL: (86 g/m2)/(0.235 mm)/0.80 = 457 kg/m3, based on areic weight, thickness, and porosity from [SGL2004]
      //     Graphite (pyrolytic): rho = 2210 kg/m3 [Incropera2002, p. 909]
      //     Amorphous carbon: rho = 1950 kg/m3 [Incropera2002, p. 909]

      // Electrical resistivity of the GDL material (excluding the effect of porosity)
      //     SGL Sigracet 10 BA GDL: (12 mohm.cm2)*(1 - 0.88)^1.5/(0.400 mm) = 0.1247 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2007]
      //     SGL Sigracet 10 BB GDL: (15 mohm.cm2)*(1 - 0.84)^1.5/(0.420 mm) = 0.2286 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2007]
      //     SGL Sigracet 10 BC GDL: (16 mohm.cm2)*(1 - 0.82)^1.5/(0.420 mm) = 0.2909 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2007]
      //     SGL Sigracet 24 BA GDL: (10 mohm.cm2)*(1 - 0.84)^1.5/(0.190 mm) = 0.3368 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2004]
      //     SGL Sigracet 24 BC GDL: (11 mohm.cm2)*(1 - 0.76)^1.5/(0.235 mm) = 0.5504 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2004]
      //     SGL Sigracet 25 BA GDL: (10 mohm.cm2)*(1 - 0.88)^1.5/(0.190 mm) = 0.2188 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2004]
      //     SGL Sigracet 25 BC GDL: (12 mohm.cm2)*(1 - 0.80)^1.5/(0.235 mm) = 0.4567 mohm.m, based on electrical resistivity (through plane), porosity, and thickness from [SGL2004]
      // Note:  Based on [Weber2004, p. 4696, Eq. 38], the resistivity of GDL is adjusted by a factor of (1 - epsilon)^-1.5,
      // assuming all of the solid volume is electrically conducting.
      // (1 - epsilon) is the volume fraction of the conducting solid, and the power of (1 - epsilon)^(3/2) is the area fraction of the conducting solid.

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage, reaction, and transport of
chemical/electrochemical species in and through the anode catalyst layer of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
The y axis extends along the length of the channel and
the z axis extends across the width of the channel.</p>
<p>For more information, see the
    <a href=\"modelica://FCSys.Regions.BaseClasses.PartialRegion\">PartialRegion</a> model.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-22.6085,-62.7355},{-56.551,-79.7156}},
                  lineColor={64,64,64},
                  rotation=45,
                  fillColor={127,127,127},
                  fillPattern=FillPattern.HorizontalCylinder,
                  origin={-34.3741,132.347}),Rectangle(
                  extent={{-105.39,79.1846},{-139.33,70.6991}},
                  lineColor={0,0,0},
                  fillColor={200,200,200},
                  rotation=45,
                  fillPattern=FillPattern.HorizontalCylinder,
                  origin={148.513,82.5291}),Polygon(
                  points={{-14,40},{6,60},{14,60},{-6,40},{-14,40}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  pattern=LinePattern.None),Rectangle(
                  extent={{-6,40},{6,-60}},
                  lineColor={0,0,0},
                  fillColor={200,200,200},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-38,40},{-14,-60}},
                  lineColor={64,64,64},
                  fillColor={127,127,127},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-14,40},{-6,-60}},
                  fillPattern=FillPattern.Solid,
                  fillColor={0,0,0},
                  pattern=LinePattern.None),Polygon(
                  points={{-20,0},{-20,40},{0,60},{20,60},{20,0},{42,0},{42,80},
                {-42,80},{-42,0},{-20,0}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  pattern=LinePattern.None),Polygon(
                  points={{-20,0},{-20,-60},{0,-60},{20,-40},{20,0},{42,0},{42,
                -80},{-42,-80},{-42,0},{-20,0}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  pattern=LinePattern.None),Polygon(points={{0,60},{20,60},{0,
              40},{-20,40},{0,60}}, lineColor={0,0,0}),Rectangle(
                  extent={{-20,40},{0,-60}},
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Polygon(
                  points={{20,60},{0,40},{0,-60},{20,-40},{20,60}},
                  lineColor={0,0,0},
                  fillColor={200,200,200},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-20,0},{-100,0}},
                  color={240,0,0},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{10,0},{100,0}},
                  color={240,0,0},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{0,-60},{0,-100}},
                  color={240,0,0},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={240,0,0},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={240,0,0},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={240,0,0},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}));
    end AnCL;

    model AnCGDL "Integrated anode catalyst/gas diffusion layer"
      extends AnCL(L_x=fill((28.7*U.micro*U.m + 0.3*U.mm)/1, 1));

      parameter Q.NumberAbsolute lambda_IC=14
        "<html>Initial molar ratio of H<sub>2</sub>O to SO<sub>3</sub>H (&lambda;<sub>IC</sub>)</html>";
      annotation (Documentation(info="<html><p>For more information, see the
    <a href=\"modelica://FCSys.Regions.AnCLs.AnCL\">AnCL</a> and <a href=\"modelica://FCSys.Regions.AnGDLs.AnGDL\">AnGDL</a> models</p></html>"));
    end AnCGDL;
  end AnCLs;

  package PEMs "Proton exchange membranes"
    extends Modelica.Icons.Package;
    model PEM "Proton exchange membrane"
      //extends FCSys.BaseClasses.Icons.Names.Top4;
      // Note:  Extensions of PEM should be placed directly in the PEMs
      // package rather than nested packages (e.g., by manufacturer) so that
      // __Dymola_choicesFromPackage can be used.  In Dymola 7.4, the
      // parameter dialogs launch too slowly when __Dymola_choicesAllMatching
      // is used.

      extends FCSys.Regions.Region(
        L_x=fill(100*U.micro*U.m/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        inclYFaces=false,
        inclZFaces=false,
        redeclare FCSys.Subregions.SubregionNoGraphite subregions[n_x, n_y, n_z]
          (
          each inclReact=false,
          each gas(inclH2O=true, H2O(
              p_IC=defaults.y_H2O*defaults.p,
              setXVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false))),
          each ionomer(
            inclC19HF37O5S=true,
            'inclH+'=true,
            C19HF37O5S(V_IC=0.95*V),
            'H+'(
              setXVel=true,
              final epsilon=0,
              negativeY(viscousX=false),
              positiveY(viscousX=false)))));
      //'H+'(partNumInitMeth=InitMethScalar.VolumeSpecific, v_IC=U.L/(0.95*U.mol)

      parameter Q.NumberAbsolute lambda_IC=14
        "<html>Initial molar ratio of H<sub>2</sub>O to SO<sub>3</sub>H (&lambda;<sub>IC</sub>)</html>"
        annotation (Dialog(group="Initialization"));

      // TODO: Clean up (move to Species models if appropriate):

      // Note:  In Dymola 7.4, the following can't be used:
      //     each final N_IC=lambda_IC*subregions[1, 1, 1].ionomer.C19HF37O5S.N_IC)
      // due to the following error:
      //     "The left hand side of the following equation is a scalar and the
      //     right hand side is a 3 dimensional array, i.e. it has non-compatible
      //     parts"
      // even though subregions and thus H2O.N_IC is a 3D array.  Instead, the
      // lambda ratio is multiplied by the first subregion's C19HF37O5S.N_IC and
      // applied to each H2O.N_IC.  A similar note applies to
      // C19HF37O5S.V_IC.

      // Eq. 16 from [Springer1991] gives ratio of H2O molecules to SO3- units of
      // Nafion EW 1100 series:
      //     lambda_30degC = 0.043 + 17.81*a - 39.85*a^2 + 36.0*a^3
      //     => lambda = 3.4855 in equilibrium with 50% RH gas @ 30 degC
      //     => lambda = 14.003 in equilibrium with 100% RH gas @ 30 degC
      // The change in thickness and linear expansion of Nafion 1100 EW series are 14%
      // and 15% (respectively) from 50% RH @ 23 degC to water soaked @ 100 degC (DuPont,
      // "Nafion PFSA Membranes N-112, NE-1135, N-115, N-117, NE-1110", 2004).  This
      // corresponds to a volumic expansion of 51%.  Meanwhile, the water content
      // increased from 5% to 38% on a dry-weight basis.  Therefore, based on this
      // interval, the Amagat specific volume of H2O in Nafion is **m3/C.

      // Free proton density from [Spry2009, p. 10214]:
      //     @ lambda = 12: 0.95 M
      //     @ lambda = 22: 0.54 M
      // where lambda is the ratio of water molecules to sulfonic acid units.

      // TODO: Add proper value of beta_N and beta_Phi for the resistance to H+ transport.

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

    initial equation
      //subregions.gas.H2O.N = subregions.ionomer.C19HF37O5S.N*lambda_IC;

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage and transport of
chemical/electrochemical species in and through the proton exchange membrane of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
The y axis extends along the length of the channel and
the z axis extends across the width of the channel.</p>

<p>Assumptions:<ol>
<li>There are no pores in the PEM.  All H<sub>2</sub>O is absorbed into the ionomer itself.</li>
</ul></p>

<p>For more information, see the
    <a href=\"modelica://FCSys.Regions.BaseClasses.PartialRegion\">PartialRegion</a> model.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-99.092,-21.1179},{-84.9489,-63.5448}},
                  lineColor={200,200,200},
                  fillColor={255,255,255},
                  rotation=-45,
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={95.001,14.864}),Rectangle(
                  extent={{-20,40},{0,-60}},
                  lineColor={200,200,200},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{20,0},{42,0},{42,80},{-42,80},{-42,0},{-20,0},{-20,
                40},{0,60},{20,60},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{20,0},{42,0},{42,-80},{-42,-80},{-42,0},{-20,0},{-20,
                -60},{0,-60},{20,-40},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{0,40},{20,60},{20,-40},{0,-60},{0,40}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Solid,
                  fillColor={200,200,200}),Rectangle(extent={{-20,40},{0,-60}},
              lineColor={0,0,0}),Polygon(
                  points={{0,60},{20,60},{0,40},{-20,40},{0,60}},
                  lineColor={0,0,0},
                  smooth=Smooth.None),Line(
                  points={{-20,0},{-100,0}},
                  color={240,0,0},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{10,0},{100,0}},
                  color={0,0,240},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{0,-60},{0,-100}},
                  color={127,127,127},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={127,127,127},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={127,127,127},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={127,127,127},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}));
    end PEM;

    model DuPontN112 "<html>DuPont<sup>TM</sup> Nafion&reg; N-112</html>"
      extends PEM(L_x=fill(51*U.micro*U.m/1, 1));
      // See [DuPont2004N]:
      //     Protonic resistivity: (1/0.083) ohm.cm
      //     Density: (100 g/m2)/(51 um) = 1.9608 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
          <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontN112;

    model DuPontN115 "<html>DuPont<sup>TM</sup> Nafion&reg; N-115</html>"
      extends PEM(L_x=fill(127*U.micro*U.m/1, 1));
      // See [DuPont2004N] and [DuPont2005]:
      //     Protonic resistivity: 10 ohm.cm
      //     Density: (250 g/m2)/(127 um) = 1.9685 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontN115;

    model DuPontN117 "<html>DuPont<sup>TM</sup> Nafion&reg; N-115</html>"
      extends PEM(L_x=fill(183*U.micro*U.m/1, 1));
      // See [DuPont2004N] and [DuPont2005]:
      //     Protonic resistivity: 10 ohm.cm
      //     Density: (360 g/m2)/(183 um) = 1.9672 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontN117;

    model DuPontNE1110 "<html>DuPont<sup>TM</sup> Nafion&reg; NE-1110</html>"
      extends PEM(L_x=fill(254*U.micro*U.m/1, 1));
      // See [DuPont2004N] and [DuPont2005]:
      //     Protonic resistivity: 10 ohm.cm
      //     Density: (500 g/m2)/(254 um) = 1.9685 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontNE1110;

    model DuPontNE1135 "<html>DuPont<sup>TM</sup> Nafion&reg; NE-1135</html>"
      extends PEM(L_x=fill(89*U.micro*U.m/1, 1));
      // See [DuPont2004N]:
      //     Protonic resistivity: 10 ohm.cm
      //     Density: (190 g/m2)/(89 um) = 2.1348 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontNE1135;

    model DuPontNRE211 "<html>DuPont<sup>TM</sup> Nafion&reg; NRE-1110</html>"
      extends PEM(L_x=fill(25.4*U.micro*U.m/1, 1));
      // See [DuPont2004NRE]:
      //     Protonic resistivity not listed
      //     Density: (50 g/m2)/(25.4 um) = 1.9685 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontNRE211;

    model DuPontNRE212 "<html>DuPont<sup>TM</sup> Nafion&reg; NRE-1110</html>"
      extends PEM(L_x=fill(50.8*U.micro*U.m/1, 1));
      // See [DuPont2004NRE]:
      //     Protonic resistivity not listed
      //     Density: (100 g/m2)/(50.8 um) = 1.9685 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="pEM",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.PEMs.PEM\">PEM</a> model.</p></html>"));
    end DuPontNRE212;
  end PEMs;

  package CaCLs "Cathode catalyst layers"
    extends Modelica.Icons.Package;
    model CaCL "Cathode catalyst layer"
      //extends FCSys.BaseClasses.Icons.Names.Top4;

      extends FCSys.Regions.Region(
        L_x=fill(28.7*U.micro*U.m/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        inclYFaces=false,
        inclZFaces=false,
        redeclare FCSys.Subregions.Subregion subregions[n_x, n_y, n_z](
          each gas(
            inclH2O=true,
            inclN2=true,
            inclO2=true,
            H2O(
              setXVel=true,
              p_IC=defaults.y_H2O*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false)),
            N2(
              p_IC=(1 - defaults.y_H2O)*(1 - defaults.y_O2_dry)*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setXVel=true),
            O2(
              p_IC=(1 - defaults.y_H2O)*defaults.y_O2_dry*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setXVel=true)),
          each graphite(
            inclC=true,
            'incle-'=true,
            C(V_IC=(V - xV)/2),
            'e-'(
              setXVel=true,
              mu_IC=-0.3*U.V,
              negativeY(viscousX=false),
              positiveY(viscousX=false),
              setTemp=true)),
          each ionomer(
            inclC19HF37O5S=true,
            'inclH+'=true,
            C19HF37O5S(V_IC=(V - xV)/2),
            'H+'(
              setXVel=true,
              partNumInitMeth=InitMethScalar.ReactionRate,
              Ndot_IC=0*U.A,
              negativeY(viscousX=false),
              positiveY(viscousX=false)))));
      // **temp nonzero Ndot_IC
      //'e-'(negativeX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
      //'H+'(positiveX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
      //N_IC=1*U.q,
      //'H+'(partNumInitMeth=InitMethScalar.VolumeSpecific, v_IC=U.L/(0.95*U.mol)))));

      //O2(
      //     alpha_N=1e49*FCSys.Characteristics.O2.gas.beta())
      //      each graphite('e-'(alpha_N=1e49*
      //          FCSys.Characteristics.'e-'.graphite.beta())),
      //  each ionomer(C19HF37O5S(V_IC=0.15*V), 'H+'(alpha_N=1e49*
      //          FCSys.Characteristics.'H+'.solid.beta()))));

      //
      //

      //partNumInitMeth=InitMethScalar.ReactionRate

      // See AnCLs.AnCL for data on additional materials.

      parameter Q.NumberAbsolute x(nominal=1) = 0.25 "Volumetric porosity";
      parameter Q.NumberAbsolute lambda_IC=14
        "<html>Initial molar ratio of H<sub>2</sub>O to SO<sub>3</sub>H (&lambda;<sub>IC</sub>)</html>"
        annotation (Dialog(group="Initialization"));
      // TODO: Add H2O to the ionomer according to lambda_IC.
      // TODO: Include reaction to absorb H2O into ionomer.
      // Assume zero volume of H2O in the ionomer?
    protected
      final parameter Q.Volume xV=x*V "Gas volume";

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage, reaction, and transport of
chemical/electrochemical species in and through the cathode catalyst layer of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
The y axis extends along the length of the channel and
the z axis extends across the width of the channel.</p>
<p>For more information, see the
    <a href=\"modelica://FCSys.Regions.BaseClasses.PartialRegion\">PartialRegion</a> model.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-21.6329,-68.4511},{-58.4038,-85.4311}},
                  lineColor={64,64,64},
                  rotation=45,
                  fillColor={127,127,127},
                  fillPattern=FillPattern.HorizontalCylinder,
                  origin={-15.1055,127.699}),Rectangle(
                  extent={{-105.385,79.1805},{-139.323,70.6948}},
                  lineColor={0,0,0},
                  fillColor={200,200,200},
                  rotation=45,
                  fillPattern=FillPattern.HorizontalCylinder,
                  origin={130.507,84.5292}),Polygon(
                  points={{-14,40},{6,60},{14,60},{-6,40},{-14,40}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  pattern=LinePattern.None),Rectangle(
                  extent={{-26,40},{-14,-60}},
                  lineColor={0,0,0},
                  fillColor={200,200,200},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-6,40},{18,-60}},
                  lineColor={64,64,64},
                  fillColor={127,127,127},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-14,40},{-6,-60}},
                  fillPattern=FillPattern.Solid,
                  fillColor={0,0,0},
                  pattern=LinePattern.None),Polygon(
                  points={{-20,0},{-20,40},{0,60},{20,60},{20,0},{42,0},{42,80},
                {-42,80},{-42,0},{-20,0}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  pattern=LinePattern.None),Polygon(
                  points={{-20,0},{-20,-60},{0,-60},{20,-40},{20,0},{42,0},{42,
                -80},{-42,-80},{-42,0},{-20,0}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  pattern=LinePattern.None),Polygon(points={{0,60},{20,60},{0,
              40},{-20,40},{0,60}}, lineColor={0,0,0}),Rectangle(
                  extent={{-20,40},{0,-60}},
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),Polygon(
                  points={{20,60},{0,40},{0,-60},{20,-40},{20,60}},
                  lineColor={0,0,0},
                  fillColor={120,120,120},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-20,0},{-100,0}},
                  color={0,0,240},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{10,0},{100,0}},
                  color={0,0,240},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{0,-60},{0,-98}},
                  color={0,0,240},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={0,0,240},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={0,0,240},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={0,0,240},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}));
    end CaCL;

    model CaCGDL "Integrated cathode catalyst/gas diffusion layer"
      extends CaCL(L_x=fill((28.7*U.micro*U.m + 0.3*U.mm)/1, 1));

      annotation (Documentation(info="<html><p>For more information, see the
    <a href=\"modelica://FCSys.Regions.CaCLs.CaCL\">CaCL</a> and <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> models</p></html>"));
    end CaCGDL;
  end CaCLs;

  package CaGDLs "Cathode gas diffusion layers"
    extends Modelica.Icons.Package;
    // Note:  Extensions of CaGDL should be placed directly in the CaGDLs
    // package rather than nested packages (e.g., by manufacturer) so that
    // __Dymola_choicesFromPackage can be used.  In Dymola 7.4, the
    // parameter dialogs launch too slowly when __Dymola_choicesAllMatching
    // is used.

    model CaGDL "Cathode gas diffusion layer"
      //extends FCSys.BaseClasses.Icons.Names.Top4;
      // Note:  Extensions of CaGDL should be placed directly in the CaGDLs
      // package rather than nested packages so that __Dymola_choicesFromPackage
      // can be used.  In Dymola 7.4, the parameter dialogs launch too slowly
      // when __Dymola_choicesAllMatching is used.
      extends FCSys.Regions.Region(
        L_x=fill(0.3*U.mm/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        inclYFaces=false,
        inclZFaces=false,
        redeclare FCSys.Subregions.SubregionNoIonomer subregions[n_x, n_y, n_z]
          (
          each inclReact=false,
          each gas(
            inclH2O=true,
            inclN2=true,
            inclO2=true,
            H2O(
              setXVel=true,
              p_IC=defaults.y_H2O*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false)),
            N2(
              setXVel=true,
              p_IC=(1 - defaults.y_H2O)*(1 - defaults.y_O2_dry)*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false)),
            O2(
              setXVel=true,
              p_IC=(1 - defaults.y_H2O)*defaults.y_O2_dry*defaults.p,
              negativeY(viscousX=false),
              positiveY(viscousX=false))),
          each graphite(
            inclC=true,
            'incle-'=true,
            C(V_IC=V - xV),
            'e-'(
              mu_IC=-0.3*U.V,
              final epsilon=0,
              setXVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false)))));

      parameter Q.NumberAbsolute x(nominal=1) = 0.76 "Volumetric porosity";
      // The default porosity is for Sigracet 24 BC.
    protected
      final parameter Q.Volume xV=x*V "Gas volume";

      // See AnGDLs.AnGDL for additional notes and data.

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage and transport of
chemical/electrochemical species in and through the cathode gas diffusion layer of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
The y axis extends along the length of the channel and
the z axis extends across the width of the channel.</p>
<p>For more information, see the b
    <a href=\"modelica://FCSys.Regions.BaseClasses.PartialRegion\">PartialRegion</a> model.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-78.7855,18.6813},{-50.5004,-23.7455}},
                  lineColor={64,64,64},
                  fillColor={127,127,127},
                  rotation=-45,
                  fillPattern=FillPattern.VerticalCylinder,
                  origin={52.5001,1.0805}),Rectangle(
                  extent={{-20,40},{20,-60}},
                  lineColor={64,64,64},
                  fillColor={127,127,127},
                  fillPattern=FillPattern.VerticalCylinder),Polygon(
                  points={{20,0},{42,0},{42,80},{-42,80},{-42,0},{-20,0},{-20,
                40},{0,60},{20,60},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{20,0},{42,0},{42,-80},{-42,-80},{-42,0},{-20,0},{-20,
                -60},{0,-60},{20,-40},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{0,40},{20,60},{20,-40},{0,-60},{0,40}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Solid,
                  fillColor={127,127,127}),Rectangle(extent={{-20,40},{0,-60}},
              lineColor={0,0,0}),Polygon(
                  points={{0,60},{20,60},{0,40},{-20,40},{0,60}},
                  lineColor={0,0,0},
                  smooth=Smooth.None),Line(
                  points={{-20,0},{-100,0}},
                  color={0,0,240},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{10,0},{100,0}},
                  color={0,0,240},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{0,-60},{0,-100}},
                  color={0,0,240},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={0,0,240},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={0,0,240},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={0,0,240},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}));
    end CaGDL;

    model Sigracet10BA "<html>SGL Carbon Group Sigracet&reg; 10 BA</html>"
      extends CaGDL(L_x=fill(0.400*U.mm/1, 1),x=0.88);
      // See [SGL2007]:
      //     Diffusivity: L = 0.400 mm, p = 0.85 m/s (for air) => D = P*L = 340 mm2/s
      //     Density: (85 g/m2)/(0.400 mm)/0.88 = 212.5 kg/m3
      //     Electronic resistivity: (12 mohm.cm2)/(0.400 mm) = 3 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet10BA;

    model Sigracet10BB "<html>SGL Carbon Group Sigracet&reg; 10 BB</html>"
      extends CaGDL(L_x=fill(0.420*U.mm/1, 1),x=0.84);
      // See [SGL2007]:
      //     Diffusivity: L = 0.420 mm, p = 0.03 m/s (for air) => D = P*L = 12.6 mm2/s
      //     Density: (125 g/m2)/(0.420 mm) = 297.62 kg/m3
      //     Electronic resistivity: (15 mohm.cm2)/(0.420 mm) = 3.5714 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet10BB;

    model Sigracet10BC "<html>SGL Carbon Group Sigracet&reg; 10 BC</html>"
      extends CaGDL(L_x=fill(0.420*U.mm/1, 1),x=0.82);
      // See [SGL2007]:
      //     Diffusivity: L = 0.420 mm, p = 0.0145 m/s (for air) => D = P*L = 6.09 mm2/s
      //     Density: (135 g/m2)/(0.420 mm) = 321.43 kg/m3
      //     Electronic resistivity: (16 mohm.cm2)/(0.420 mm) = 3.8095 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet10BC;

    model Sigracet24BA "<html>SGL Carbon Group Sigracet&reg; 24 BA</html>"
      extends CaGDL(L_x=fill(0.190*U.mm/1, 1),x=0.84);
      // See [SGL2007]:
      //     Diffusivity: L = 0.190 mm, p = 0.30 m/s (for air) => D = P*L = 57 mm2/s
      //     Density: (54 g/m2)/(0.190 mm) = 284.21 kg/m3
      //     Electronic resistivity: (10 mohm.cm2)/(0.190 mm) = 5.2632 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet24BA;

    model Sigracet24BC "<html>SGL Carbon Group Sigracet&reg; 24 BC</html>"
      extends CaGDL(L_x=fill(0.235*U.mm/1, 1),x=0.76);
      // See [SGL2007]:
      //     Diffusivity: L = 0.235 mm, p = 0.0045 m/s (for air) => D = P*L = 1.0575 mm2/s
      //     Density: (100 g/m2)/(0.235 mm) = 425.53 kg/m3
      //     Electronic resistivity: (11 mohm.cm2)/(0.235 mm) = 4.6809 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet24BC;

    model Sigracet25BA "<html>SGL Carbon Group Sigracet&reg; 25 BA</html>"
      extends CaGDL(L_x=fill(0.190*U.mm/1, 1),x=0.88);
      // See [SGL2007]:
      //     Diffusivity: L = 0.190 mm, p = 0.90 m/s (for air) => D = P*L = 171 mm2/s
      //     Density: (40 g/m2)/(0.190 mm) = 210.53 kg/m3
      //     Electronic resistivity: (10 mohm.cm2)/(0.190 mm) = 5.2632 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet25BA;

    model Sigracet25BC "<html>SGL Carbon Group Sigracet&reg; 25 BC</html>"
      extends CaGDL(L_x=fill(0.235*U.mm/1, 1),x=0.80);
      // See [SGL2007]:
      //     Diffusivity: L = 0.235 mm, p = 0.008 m/s (for air) => D = P*L = 1.88 mm2/s
      //     Density: (86 g/m2)/(0.235 mm) = 365.96 kg/m3
      //     Electronic resistivity: (12 mohm.cm2)/(0.235 mm) = 5.1064 mohm.m
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end Sigracet25BC;

    model TorayTGPH030 "Toray Industries TGP-H-030"
      extends CaGDL(L_x=fill(0.110*U.mm/1, 1),x=0.80);
      // See [Toray2010]:
      //     Diffusivity: L = 0.110 mm, P/p = 2500 ml.mm/(cm2.hr.mmAq) = 0.70814e-3 m/(s.kPa)
      //         => D = P*L = 7.89e-6 m2/s, assuming p = 101.325 kPa
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): not listed
      //     Thermal conductivity (through plane, 20 degC): not listed
      //     Thermal conductivity (in plane, 20 degC): not listed
      //     Thermal conductivity (in plane, 100 degC): not listed
      //     Bulk Density: 0.4 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end TorayTGPH030;

    model TorayTGPH060 "Toray Industries TGP-H-060"
      extends CaGDL(L_x=fill(0.190*U.mm/1, 1),x=0.78);
      // See [Toray2010]:
      //     Diffusivity: L = 0.190 mm, P/p = 1900 ml.mm/(cm2.hr.mmAq) = 0.53818e-3 m/(s.kPa)
      //         => D = P*L = 10.36e-6 m2/s, assuming p = 101.325 kPa
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): 5.8 mohm.cm
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end TorayTGPH060;

    model TorayTGPH090 "Toray Industries TGP-H-090"
      extends CaGDL(L_x=fill(0.280*U.mm/1, 1),x=0.78);
      // See [Toray2010]:
      //     Diffusivity: L = 0.280 mm, P/p = 1700 ml.mm/(cm2.hr.mmAq) = 0.48153e-3 m/(s.kPa)
      //         => D = P*L = 13.66e-6 m2/s, assuming p = 101.325 kPa
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): 5.6 mohm.cm
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end TorayTGPH090;

    model TorayTGPH120 "Toray Industries TGP-H-030"
      extends CaGDL(L_x=fill(0.370*U.mm/1, 1),x=0.78);
      // See [Toray2010]:
      //     Diffusivity: L = 0.370 mm, P/p = 1500 ml.mm/(cm2.hr.mmAq) = 0.42488e-3 m/(s.kPa)
      //         => D = P*L = 15.93e-6 m2/s, assuming p = 101.325 kPa");
      //     Electronic resistivity (through plane): 80 mohm.cm
      //     Electronic resistivity (in plane): 4.7 mohm.cm
      //     Thermal resistivity (through plane, 20 degC): (1/1.7) m.K/W
      //     Thermal resistivity (in plane, 20 degC): (1/21) m.K/W
      //     Thermal resistivity (in plane, 100 degC): (1/23) m.K/W
      //     Bulk density: 0.44 g/cm3
      annotation (
        defaultComponentPrefixes="replaceable",
        defaultComponentName="caGDL",
        Documentation(info="<html><p>For more information, see the
                <a href=\"modelica://FCSys.Regions.CaGDLs.CaGDL\">CaGDL</a> model.</p></html>"));
    end TorayTGPH120;
  end CaGDLs;

  package CaFPs "Cathode flow plates"
    extends Modelica.Icons.Package;
    model CaFP "Cathode flow plate"
      //extends FCSys.BaseClasses.Icons.Names.Top4;

      extends FCSys.Regions.Region(
        L_x=fill(8*U.mm/1, 1),
        L_y=fill(1*U.m/1, 1),
        L_z=fill(5*U.mm/1, 1),
        final inclXFaces=true,
        final inclYFaces=true,
        inclZFaces=false,
        redeclare FCSys.Subregions.SubregionNoIonomer subregions[n_x, n_y, n_z]
          (
          each inclReact=false,
          each gas(
            inclH2O=true,
            inclN2=true,
            inclO2=true,
            H2O(
              setXVel=true,
              p_IC=defaults.y_H2O*defaults.p,
              positiveX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
              negativeY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false),
              positiveY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false)),
            N2(
              setXVel=true,
              p_IC=(1 - defaults.y_H2O)*(1 - defaults.y_O2_dry)*defaults.p,
              positiveX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
              negativeY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false),
              positiveY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false)),
            O2(
              setXVel=true,
              p_IC=(1 - defaults.y_H2O)*defaults.y_O2_dry*defaults.p,
              positiveX(matEntOpt=MaterialEntropyOpt.ClosedAdiabatic),
              negativeY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false),
              positiveY(matEntOpt=MaterialEntropyOpt.OpenDiabatic, viscousX=
                    false))),
          each graphite(
            inclC=true,
            'incle-'=true,
            C(V_IC=V - xV),
            'e-'(
              mu_IC=-0.3*U.V,
              final epsilon=0,
              setXVel=true,
              setYVel=true,
              negativeY(viscousX=false),
              positiveY(viscousX=false)))));

      parameter Q.NumberAbsolute x(nominal=1) = 0.1 "Volumetric porosity";
    protected
      final parameter Q.Volume xV=x*V "Gas volume";

      // The specific heat capacity at constant pressure and thermal
      // resistivity is based on data of graphite fiber epoxy (25% vol)
      // composite (heat flow parallel to fibers) at 300 K from Incropera and
      // DeWitt (2002, p. 909).  See FCSys.Subregions.Species.C.Fixed for more
      // data.

      // See AnFPs.AnFP for data on additional materials.

    protected
      outer BCs.Defaults defaults "Default settings" annotation (Placement(
            transformation(extent={{40,40},{60,60}}), iconTransformation(extent
              ={{-10,90},{10,110}})));

      annotation (
        defaultComponentPrefixes="replaceable",
        Documentation(info="<html>
<p>This model describes the storage and transport of chemical/electrochemical
species in and through the cathode flow plate of a PEMFC.
The x axis is intended to extend from the anode to the cathode.
and the y axis extends along the length of the channel. The model is
bidirectional, so that either <code>negativeY</code> or <code>positiveY</code> can be
used as the inlet. The z axis extends across the width of the channel.</p>
<p>For more information, see the
  <a href=\"modelica://FCSys.Regions.BaseClasses.PartialRegion\">PartialRegion</a> model.</p>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            initialScale=0.1), graphics={Rectangle(
                  extent={{-100,60},{100,100}},
                  fillColor={255,255,255},
                  visible=not inclYFaces,
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(
                  extent={{-76.648,66.211},{-119.073,52.0689}},
                  fillPattern=FillPattern.HorizontalCylinder,
                  rotation=45,
                  fillColor={135,135,135},
                  origin={111.017,77.3801},
                  pattern=LinePattern.None,
                  lineColor={95,95,95}),Rectangle(
                  extent={{-20,40},{0,-60}},
                  lineColor={95,95,95},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={135,135,135}),Polygon(
                  points={{20,0},{42,0},{42,80},{-42,80},{-42,0},{-20,0},{-20,
                40},{0,60},{20,60},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Polygon(
                  points={{20,0},{42,0},{42,-80},{-42,-80},{-42,0},{-20,0},{-20,
                -60},{0,-60},{20,-40},{20,0}},
                  smooth=Smooth.None,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),Rectangle(extent={{-20,40},{0,-60}},
              lineColor={0,0,0}),Polygon(
                  points={{-20,40},{0,60},{20,60},{0,40},{-20,40}},
                  lineColor={0,0,0},
                  smooth=Smooth.None),Polygon(
                  points={{20,60},{0,40},{0,-60},{20,-40},{20,60}},
                  lineColor={0,0,0},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-20,0},{-100,0}},
                  color={0,0,240},
                  visible=inclXFaces,
                  thickness=0.5),Line(
                  points={{10,0},{100,0}},
                  color={127,127,127},
                  visible=inclXFaces,
                  thickness=0.5),Ellipse(
                  extent={{-4,52},{4,48}},
                  lineColor={135,135,135},
                  fillColor={0,0,240},
                  visible=inclYFaces,
                  fillPattern=FillPattern.Sphere),Line(
                  points={{0,-60},{0,-100}},
                  color={0,0,240},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{0,100},{0,50}},
                  color={0,0,240},
                  visible=inclYFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{-50,-50},{-10,-10}},
                  color={0,0,240},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Line(
                  points={{20,20},{50,50}},
                  color={0,0,240},
                  visible=inclZFaces,
                  smooth=Smooth.None,
                  thickness=0.5),Text(
                  extent={{-100,60},{100,100}},
                  textString="%name",
                  visible=not inclYFaces,
                  lineColor={0,0,0})}),
        Diagram(graphics));
    end CaFP;

    model GM "General Motors cathodic test flow plate and current collector"
      extends CaFP(
        subregions(each graphite(C(alpha_S=U.m*U.K/(95*U.W), beta_S=U.m*U.K/(95
                  *U.W)))),
        L_x=fill(35.22*U.mm/1, 1),
        L_y=fill(1.028*U.m, 1),
        L_z=fill((5/1.028)*U.mm, 1),
        x=0.011);

      annotation (Documentation(info="<html><p>Assumptions:<ol>
<li>The x-axis length of this region is the thickness
of the GM-compatible <a href=\"modelica://FCSys/resources/documentation/Regions/CaFPs/GM/Flow field.pdf\">flow field</a>,
<a href=\"modelica://FCSys/resources/documentation/Regions/CaFPs/GM/Current collector plate.pdf\">current collector plate</a>,
 and <a href=\"modelica://FCSys/resources/documentation/Regions/CaFPs/GM/End plate.pdf\">end plate</a> combined.  The material properties are those of epoxy-filled
graphite, although the current collector is actually gold-plated copper and the end plate is actually aluminum.</li>
<li>The y-axis length of this region is the length of the triple-serpentine flow channels of the
GM-compatible
cathode <a href=\"modelica://FCSys/resources/documentation/Regions/AnFPs/GM/Flow field.pdf\">flow field</a> as if they were straightened.</li>
<li>The z-axis length of this region is 50 cm<sup>2</sup> divided by the y-axis length.  Only the active area
(50 cm<sup>2</sup>) is modeled&mdash;not the entire area (100 cm<sup>2</sup>).
<li>It is assumed that the solid (graphite/epoxy composite) constitutes the entire volume except for the flow channels.
In reality, there are cut-outs and holes for thermocouples, hardware, etc.</li>
</ol></p>
<p>Additional notes:
<ul>
<li>The default thermal resistivity ((1/95) m K/W) is that of Entegris/Poco Graphite AXM-5Q
[<a href=\"modelica://FCSys.UsersGuide.References\">Entegris2012</a>].</li>
</ul>
</p></html>"));
    end GM;
  end CaFPs;

  partial model Region "Base model for a 3D array of subregions"
    //extends FCSys.BaseClasses.Icons.Names.Top3;
    //extends FCSys.BaseClasses.Icons.Names.Top6;

    // General parameters
    parameter Q.Length L_x[:](each final min=Modelica.Constants.small) = fill(1
      *U.m/1, 1) "<html>Lengths along the x axis (<i>L</i><sub>x</sub>)</html>"
      annotation (Dialog(group="Geometry"));
    parameter Q.Length L_y[:](each final min=Modelica.Constants.small) = fill(1
      *U.m/1, 1) "<html>Lengths along the y axis (<i>L</i><sub>y</sub>)</html>"
      annotation (Dialog(group="Geometry"));
    parameter Q.Length L_z[:](each final min=Modelica.Constants.small) = fill(1
      *U.m/1, 1) "<html>Lengths along the z axis (<i>L</i><sub>z</sub>)</html>"
      annotation (Dialog(group="Geometry"));
    final parameter Integer n_x=size(L_x, 1)
      "Number of sets of subregions along the x axis"
      annotation (Evaluate=true, HideResult=true);
    final parameter Integer n_y=size(L_y, 1)
      "Number of sets of subregions along the y axis"
      annotation (Evaluate=true, HideResult=true);
    final parameter Integer n_z=size(L_z, 1)
      "Number of sets of subregions along the z axis"
      annotation (Evaluate=true, HideResult=true);
    final parameter Q.Length L[3]={sum(L_x),sum(L_y),sum(L_z)} if hasSubregions
      "Length";
    final parameter Q.Area A[3]={L[cartWrap(ax + 1)]*L[cartWrap(ax + 2)] for ax
         in 1:3} if hasSubregions "Cross-sectional area";
    final parameter Q.Volume V=product(L) if hasSubregions "Volume";

    // Assumptions about included faces
    parameter Boolean inclXFaces=true "X" annotation (
      Evaluate=true,
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        tab="Assumptions",
        group="Axes with faces included",
        compact=true));
    parameter Boolean inclYFaces=true "Y" annotation (
      Evaluate=true,
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        tab="Assumptions",
        group="Axes with faces included",
        compact=true));
    parameter Boolean inclZFaces=true "Z" annotation (
      Evaluate=true,
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(
        tab="Assumptions",
        group="Axes with faces included",
        compact=true));

    FCSys.Connectors.FaceBus negativeX[n_y, n_z] if inclXFaces
      "Negative face along the x axis" annotation (Placement(transformation(
            extent={{-50,-10},{-30,10}}), iconTransformation(extent={{-110,-10},
              {-90,10}})));
    FCSys.Connectors.FaceBus positiveX[n_y, n_z] if inclXFaces
      "Positive face along the x axis" annotation (Placement(transformation(
            extent={{30,-10},{50,10}}), iconTransformation(extent={{90,-10},{
              110,10}})));
    FCSys.Connectors.FaceBus negativeY[n_x, n_z] if inclYFaces
      "Negative face along the y axis" annotation (Placement(transformation(
            extent={{-10,-50},{10,-30}}), iconTransformation(extent={{-10,-110},
              {10,-90}})));
    FCSys.Connectors.FaceBus positiveY[n_x, n_z] if inclYFaces
      "Positive face along the y axis" annotation (Placement(transformation(
            extent={{-10,30},{10,50}}), iconTransformation(extent={{-10,90},{10,
              110}})));
    FCSys.Connectors.FaceBus negativeZ[n_x, n_y] if inclZFaces
      "Negative face along the z axis" annotation (Placement(transformation(
            extent={{10,10},{30,30}}), iconTransformation(extent={{40,40},{60,
              60}})));
    FCSys.Connectors.FaceBus positiveZ[n_x, n_y] if inclZFaces
      "Positive face along the z axis" annotation (Placement(transformation(
            extent={{-30,-30},{-10,-10}}), iconTransformation(extent={{-60,-60},
              {-40,-40}})));

    replaceable FCSys.Subregions.Subregion subregions[n_x, n_y, n_z] if
      hasSubregions constrainedby FCSys.Subregions.BaseClasses.PartialSubregion(
      final L={{L_x[i_x],L_y[i_y],L_z[i_z]} for i_z in 1:n_z, i_y in 1:n_y, i_x
           in 1:n_x},
      each final inclXFaces=inclXFaces,
      each final inclYFaces=inclYFaces,
      each final inclZFaces=inclZFaces)
      "Base subregion model and its modifications for each subregion"
      annotation (__Dymola_choicesAllMatching=true, Placement(transformation(
            extent={{-10,-10},{10,10}})));

  protected
    final parameter Boolean hasSubregions=n_x > 0 and n_y > 0 and n_z > 0
      "true, if there are any subregions" annotation (Evaluate=true);

  equation
    // X axis
    connect(negativeX, subregions[1, :, :].negativeX) annotation (Line(
        points={{-40,5.55112e-16},{-38,5.55112e-16},{-40,0},{-30,0},{-30,
            6.10623e-16},{-10,6.10623e-16}},
        color={127,127,127},
        smooth=Smooth.None,
        thickness=0.5));
    for i in 1:n_x - 1 loop
      connect(subregions[i, :, :].positiveX, subregions[i + 1, :, :].negativeX)
        "Connection b/w neighboring subregions (not shown the diagram)";
    end for;
    connect(subregions[n_x, :, :].positiveX, positiveX) annotation (Line(
        points={{10,6.10623e-16},{20,6.10623e-16},{20,0},{30,0},{30,5.55112e-16},
            {40,5.55112e-16}},
        color={127,127,127},
        smooth=Smooth.None,
        thickness=0.5));
    if n_x == 0 then
      connect(negativeX, positiveX)
        "Direct pass-through (not shown the diagram)";
    end if;

    // Y axis
    connect(negativeY, subregions[:, 1, :].negativeY) annotation (Line(
        points={{5.55112e-16,-40},{0,-10},{6.10623e-16,-10}},
        color={127,127,127},
        smooth=Smooth.None,
        thickness=0.5));
    for i in 1:n_y - 1 loop
      connect(subregions[:, i, :].positiveY, subregions[:, i + 1, :].negativeY)
        "Connection b/w neighboring subregions (not shown the diagram)";
    end for;
    connect(subregions[:, n_y, :].positiveY, positiveY) annotation (Line(
        points={{6.10623e-16,10},{6.10623e-16,24},{0,24},{0,40},{5.55112e-16,40}},

        color={127,127,127},
        smooth=Smooth.None,
        thickness=0.5));

    if n_y == 0 then
      connect(negativeY, positiveY)
        "Direct pass-through (not shown the diagram)";
    end if;

    // Z axis
    connect(negativeZ, subregions[:, :, 1].negativeZ) annotation (Line(
        points={{20,20},{5,5}},
        color={127,127,127},
        smooth=Smooth.None,
        thickness=0.5));
    for i in 1:n_z - 1 loop
      connect(subregions[:, :, i].positiveZ, subregions[:, :, i + 1].negativeZ)
        "Connection b/w neighboring subregions (not shown the diagram)";
    end for;
    connect(positiveZ, subregions[:, :, n_z].positiveZ) annotation (Line(
        points={{-20,-20},{-5,-5}},
        color={127,127,127},
        smooth=Smooth.None,
        thickness=0.5));
    if n_z == 0 then
      connect(negativeZ, positiveZ)
        "Direct pass-through (not shown the diagram)";
    end if;
    annotation (
      Documentation(info="<html><p>The following notes apply to the parameters:
  <ul>
  <li>If <code>L_x = zeros(0)</code> (or <code>ones(0)</code> or <code>fill(1, 0)</code>), then there are no
   subregions along the x axis and the boundaries along the x axis are
   directly connected.  The same applies to the other axes.</li>
  </ul>
  </p>
</html>"),
      Placement(transformation(extent={{-10,-10},{10,10}})),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
              extent={{-100,120},{100,160}},
              fillColor={255,255,255},
              visible=inclYFaces,
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Text(
              extent={{-100,120},{100,160}},
              textString="%name",
              visible=inclYFaces,
              lineColor={0,0,0}),Rectangle(
              extent={{-100,56},{100,96}},
              fillColor={255,255,255},
              visible=not inclYFaces,
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),Text(
              extent={{-100,56},{100,96}},
              textString="%name",
              visible=not inclYFaces,
              lineColor={0,0,0})}));
  end Region;
  annotation (Documentation(info="<html>
<p>
<b>Licensed by Kevin Davies under the Modelica License 2</b><br>
Copyright 2007&ndash;2012, Kevin Davies.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the
disclaimer of warranty) see <a href=\"modelica://FCSys.UsersGuide.ModelicaLicense2\">
FCSys.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">
http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"));
end Regions;
