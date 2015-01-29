package com.statistics;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class Rtest {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("Rtest start");
		RConnection c;
		try {
			c = new RConnection("hbsys98.vps.phps.kr", 6311);
			REXP x = c.eval("1+2");
			System.out.println(x.asInteger());
		} catch (RserveException e) {
			e.printStackTrace();
		} catch (REXPMismatchException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}