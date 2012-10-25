within FCSys;
package Quantities "Quantities to represent physical properties"

  extends Modelica.Icons.Package;
  import Modelica.Icons.TypeReal;

  package Examples "Examples and tests"
    extends Modelica.Icons.ExamplesPackage;
    model TestQuantities "Test the display units for selected quantities"
      extends Modelica.Icons.Example;

      Q.Examples.ExampleModel doubleClickMe annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,0})));
      annotation (Diagram(graphics));
    end TestQuantities;

    model ExampleModel "Model that instantiates all of the quantities"
      extends FCSys.BaseClasses.Icons.Blocks.Continuous;

      // Generated from FCSys/resources/quantities.xls
      // 10/5/2012

      parameter Q.Acceleration Acceleration=1*U.m/U.s^2 "Acceleration";
      parameter Q.Angle Angle=1*U.rad "Angle";
      parameter Q.Angle2 Angle2=1*U.sr "Solid angle";
      parameter Q.Area Area=1*U.m^2 "Area";
      parameter Q.Capacitance Capacitance=1*U.F "Capacitance";
      parameter Q.ConductanceElectrical ConductanceElectrical=1*U.S
        "Electrical conductance";
      parameter Q.Current Current=1*U.A "Current";
      parameter Q.CurrentAreic CurrentAreic=1*U.A/U.m^2 "Areic current";
      parameter Q.CurrentRate CurrentRate=1*U.A/U.s "Rate of current";
      parameter Q.Energy Energy=1*U.J "Energy";
      parameter Q.EnergyMassic EnergyMassic=1*U.Sv "Massic energy";
      parameter Q.Force Force=1*U.N "Force";
      parameter Q.Frequency Frequency=1*U.rad/U.s "Frequency";
      parameter Q.Inductance Inductance=1*U.H "Inductance";
      parameter Q.Length Length=1*U.m "Length";
      parameter Q.LengthSpecific LengthSpecific=1*U.m/U.C "Specific length";
      parameter Q.MagneticFlux MagneticFlux=1*U.Wb "Magnetic flux";
      parameter Q.MagneticFluxAreic MagneticFluxAreic=1*U.T
        "Areic magnetic flux";
      parameter Q.MagneticFluxReciprocal MagneticFluxReciprocal=1/U.Wb
        "Reciprocal magnetic flux";
      parameter Q.Mass Mass=1*U.kg "Mass";
      parameter Q.MassSpecific MassSpecific=1*U.kg/U.C "Specific mass";
      parameter Q.MomentumAngular MomentumAngular=1*U.J*U.s/U.rad
        "Angular momentum";
      parameter Q.Number Number=1 "Number";
      parameter Q.NumberAbsolute NumberAbsolute=1 "Absolute number";
      parameter Q.NumberRate NumberRate=1/U.s "Rate of number";
      parameter Q.ParticleNumber ParticleNumber=1*U.C "Particle number";
      parameter Q.ParticleNumberReciprocal ParticleNumberReciprocal=1/U.C
        "Reciprocal particle number";
      parameter Q.ParticleNumberVolumic ParticleNumberVolumic=1*U.C/U.m^3
        "Volumic particle number";
      parameter Q.Permeability Permeability=1*U.H/U.m "Permeability";
      parameter Q.Permittivity Permittivity=1*U.F/U.m "Permittivity";
      parameter Q.PermittivityReciprocal PermittivityReciprocal=1*U.m/U.H
        "Reciprocal permittivity";
      parameter Q.Potential Potential=1*U.V "Potential";
      parameter Q.PotentialAbsolute PotentialAbsolute=1*U.V
        "Absolute potential";
      parameter Q.PotentialPerWavenumber PotentialPerWavenumber=1*U.V*U.m/U.rad
        "Potential per wavenumber";
      parameter Q.PotentialRate PotentialRate=1*U.V/U.s "Rate of potential";
      parameter Q.Power Power=1*U.W "Power";
      parameter Q.PowerArea PowerArea=1*U.W*U.m^2 "Power times area";
      parameter Q.PowerAreic PowerAreic=1*U.W/U.m^2 "Areic power";
      parameter Q.PowerAreicPerPotential4 PowerAreicPerPotential4=1*U.W/(U.m^2*
          U.K^4) "Areic power per 4th power of potential";
      parameter Q.PowerRadiant PowerRadiant=1*U.'cd' "Radiant power";
      parameter Q.Pressure Pressure=1*U.Pa "Pressure";
      parameter Q.PressureAbsolute PressureAbsolute=1*U.Pa "Absolute pressure";
      parameter Q.PressureRate PressureRate=1*U.Pa/U.s "Rate of pressure";
      parameter Q.Resistance Resistance=1/U.A "Resistance";
      parameter Q.ResistanceElectrical ResistanceElectrical=1*U.ohm
        "Electrical resistance";
      parameter Q.Resistivity Resistivity=1*U.m/U.A "Resistivity";
      parameter Q.Time Time=1*U.s "Time";
      parameter Q.Velocity Velocity=1*U.m/U.s "Velocity";
      parameter Q.VelocityMassSpecific VelocityMassSpecific=1*U.kg*U.m/(U.C*U.s)
        "Velocity times specific mass";
      parameter Q.Volume Volume=1*U.m^3 "Volume";
      parameter Q.VolumeRate VolumeRate=1*U.m^3/U.s "Rate of volume";
      parameter Q.VolumeSpecific VolumeSpecific=1*U.m^3/U.C "Specific volume";
      parameter Q.VolumeSpecificRate VolumeSpecificRate=1*U.m^3/(U.C*U.s)
        "Rate of specific volume";
      parameter Q.Wavenumber Wavenumber=1*U.rad/U.m "Wavenumber";
    end ExampleModel;
  end Examples;
  // Generated from FCSys/resources/quantities.xls
  // 10/5/2012
  type Acceleration = Modelica.Icons.TypeReal (final unit="l/T2");
  type Angle = Modelica.Icons.TypeReal (final unit="A");
  type Angle2 = Modelica.Icons.TypeReal (final unit="A2") "Solid angle";
  type Area = Modelica.Icons.TypeReal (final unit="l2", min=0);
  type Capacitance = Modelica.Icons.TypeReal (final unit="N2.T2/(l2.m)");
  type ConductanceElectrical = Modelica.Icons.TypeReal (final unit=
          "N2.T/(l2.m)") "Electrical conductance";
  type Current = Modelica.Icons.TypeReal (final unit="N/T");
  type CurrentAreic = Modelica.Icons.TypeReal (final unit="N/(l2.T)")
    "Areic current";
  type CurrentRate = Modelica.Icons.TypeReal (final unit="N/T2")
    "Rate of current";
  type Energy = Modelica.Icons.TypeReal (final unit="l2.m/T2");
  type EnergyMassic = Modelica.Icons.TypeReal (final unit="l2/T2")
    "Massic energy";
  type Force = Modelica.Icons.TypeReal (final unit="l.m/T2");
  type Frequency = Modelica.Icons.TypeReal (final unit="A/T");
  type Inductance = Modelica.Icons.TypeReal (final unit="l2.m/N2");
  type Length = Modelica.Icons.TypeReal (final unit="l", min=0);
  type LengthSpecific = Modelica.Icons.TypeReal (final unit="l/N", min=0)
    "Specific length";
  type MagneticFlux = Modelica.Icons.TypeReal (final unit="l2.m/(A.N.T)")
    "Magnetic flux";
  type MagneticFluxAreic = Modelica.Icons.TypeReal (final unit="m/(A.N.T)")
    "Areic magnetic flux";
  type MagneticFluxReciprocal = Modelica.Icons.TypeReal (final unit=
          "A.N.T/(l2.m)") "Reciprocal magnetic flux";
  type Mass = Modelica.Icons.TypeReal (final unit="m", min=0);
  type MassSpecific = Modelica.Icons.TypeReal (final unit="m/N")
    "Specific mass";
  type MomentumAngular = Modelica.Icons.TypeReal (final unit="l2.m/(A.T)")
    "Angular momentum";
  type Number = Modelica.Icons.TypeReal (final unit="1");
  type NumberAbsolute = Modelica.Icons.TypeReal (final unit="1", min=0)
    "Absolute number";
  type NumberRate = Modelica.Icons.TypeReal (final unit="1/T") "Rate of number";
  type ParticleNumber = Modelica.Icons.TypeReal (final unit="N", min=0)
    "Particle number";
  type ParticleNumberReciprocal = Modelica.Icons.TypeReal (final unit="1/N")
    "Reciprocal particle number";
  type ParticleNumberVolumic = Modelica.Icons.TypeReal (final unit="N/l3", min=
          0) "Volumic particle number";
  type Permeability = Modelica.Icons.TypeReal (final unit="l.m/N2");
  type Permittivity = Modelica.Icons.TypeReal (final unit="N2.T2/(l3.m)");
  type PermittivityReciprocal = Modelica.Icons.TypeReal (final unit=
          "l3.m/(N2.T2)") "Reciprocal permittivity";
  type Potential = Modelica.Icons.TypeReal (final unit="l2.m/(N.T2)");
  type PotentialAbsolute = Modelica.Icons.TypeReal (final unit="l2.m/(N.T2)",
        min=0) "Absolute potential";
  type PotentialPerWavenumber = Modelica.Icons.TypeReal (final unit=
          "l3.m/(A.N.T2)") "Potential per wavenumber";
  type PotentialRate = Modelica.Icons.TypeReal (final unit="l2.m/(N.T3)")
    "Rate of potential";
  type Power = Modelica.Icons.TypeReal (final unit="l2.m/T3");
  type PowerArea = Modelica.Icons.TypeReal (final unit="l4.m/T3")
    "Power times area";
  type PowerAreic = Modelica.Icons.TypeReal (final unit="m/T3") "Areic power";
  type PowerAreicPerPotential4 = Modelica.Icons.TypeReal (final unit="m.T5/l8")
    "Areic power per 4th power of potential";
  type PowerRadiant = Modelica.Icons.TypeReal (final unit="l2.m/(A2.T3)")
    "Radiant power";
  type Pressure = Modelica.Icons.TypeReal (final unit="m/(l.T2)");
  type PressureAbsolute = Modelica.Icons.TypeReal (final unit="m/(l.T2)", min=0)
    "Absolute pressure";
  type PressureRate = Modelica.Icons.TypeReal (final unit="m/(l.T3)")
    "Rate of pressure";
  type Resistance = Modelica.Icons.TypeReal (final unit="T/N", min=0);
  type ResistanceElectrical = Modelica.Icons.TypeReal (final unit="l2.m/(N2.T)")
    "Electrical resistance";
  type Resistivity = Modelica.Icons.TypeReal (final unit="l.T/N", min=0);
  type Time = Modelica.Icons.TypeReal (final unit="T");
  type Velocity = Modelica.Icons.TypeReal (final unit="l/T");
  type VelocityMassSpecific = Modelica.Icons.TypeReal (final unit="l.m/(N.T)")
    "Velocity times specific mass";
  type Volume = Modelica.Icons.TypeReal (final unit="l3", min=0);
  type VolumeRate = Modelica.Icons.TypeReal (final unit="l3/T")
    "Rate of volume";
  type VolumeSpecific = Modelica.Icons.TypeReal (final unit="l3/N", min=0)
    "Specific volume";
  type VolumeSpecificRate = Modelica.Icons.TypeReal (final unit="l3/(N.T)")
    "Rate of specific volume";
  type Wavenumber = Modelica.Icons.TypeReal (final unit="A/l");
  annotation (Documentation(info="<html><p>Here, the <code>unit</code> attribute of each <code>Real</code> variable actually denotes the
  dimension.  The dimensions are noted in terms
  of angle (A), length (l), mass (m), particle number (N) and time (T).
  Capital \"L\" and \"M\" are not used to abbreviate length and mass because they are not recognized in Dymola 7.4.
  In <a href=\"modelica://FCSys.FCSys\">FCSys</a>, temperature and charge are considered
  to be derived dimensions (see the <a href=\"modelica://FCSys.Units\">Units</a> package).</p></html>"));
end Quantities;
