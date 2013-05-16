## Copyright (C) 2011 jakub
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## ssmot1

## Author: jakub <jakub@JAKUB-BEBF894F0>
## Created: 2011-09-16

function [ xdot ] = ssmot1 (t,x)
R = 0.5; %odpor vinuti kotvy
L = 5e-3; %indukcnost vinuti kotvy
Ce = 2.88; %napetova konstanta motoru * mg.tok (konst.)
U = 30; %vstupni napeti motoru
J = 0.1; %moment setrvacnosti motoru
xdot = [(-R*x(1) - Ce*x(2) + U)/L;... % = derivace proudu motoru
        Ce*x(1)/J]; % = derivace otacek motoru (bez zatizeni)
		
endfunction
