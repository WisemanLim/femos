package com.statistics;

import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;

public class rserveuseClass {
	public static void main(String[] args) throws RserveException {
		try {
//			RConnection c = new RConnection();// make a new local connection on default port (6311)
			RConnection c = new RConnection("hbsys98.vps.phps.kr", 6311);
			@SuppressWarnings("unused")
			double d[] = c.eval("rnorm(10)").asDoubles();
			for (int i=0; i<d.length; i++) {
				System.out.println(String.valueOf(d[i]));
			}
			org.rosuda.REngine.REXP x0 = c.eval("R.version.string");
			System.out.println(x0.asString());
		} catch (REngineException e) {
			// manipulation
		} catch (REXPMismatchException e) {
			// TODO Auto-generated catch block
		}
	}
}